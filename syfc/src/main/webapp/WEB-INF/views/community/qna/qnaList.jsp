<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

	<meta charset="UTF-8">

	<title>쌍용축구예약 - 자주하는 질문</title>

	<jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/dist/css/community/qnaList.css">

</head>


<body>

	<jsp:include page="/WEB-INF/views/layout/header.jsp" />

	<main class="qna-container">
	
		<div class="board-top">
				<h3>공지사항</h3>
		</div>

		<div class="qna-category">
			<button type="button" class="active" data-type="0" onclick="filterQna('0', this);">문의</button>
			
			<button type="button" data-type="1" onclick="filterQna('1', this);">신고</button>
		</div>

		<div class="qna-list">
			<c:choose>
				<c:when test="${not empty list}">
					<c:forEach var="dto" items="${list}" varStatus="status">
						<div class="qna-item" data-qtype="${dto.q_type}">
							<!-- 질문 -->
							<div class="qna-question" onclick="toggleQna(this);">
								<div class="qna-subject">
									<c:out value="${dto.q_title}" />
								</div>
								<div class="qna-arrow">
									⌄
								</div>
							</div>
							<!-- 답변 / 내용 -->
							<div class="qna-answer-box">
								<!-- 작성자 / 날짜 -->
								<div class="qna-info">
									<span class="qna-writer"><c:out value="${dto.userName}"/></span>
									<span class="qna-date">${dto.q_reg_date}</span>
								</div>
								<!-- 문의 내용 -->
								<div class="qna-question-content">
									<div class="qna-label">문의 내용</div>
									<div class="qna-content" style="white-space: pre-wrap;"><c:out value="${dto.q_question}" /></div>
								<!-- 관리자 답변 -->
								<c:choose>
									<c:when test="${not empty dto.a_answer}">
										<div class="qna-admin-answer">
											<div class="qna-label">관리자 답변</div>
											<div class="qna-content" style="white-space: pre-wrap;"><c:out value="${dto.a_answer}" /></div>
											<c:if test="${not empty dto.a_reg_date}">
												<div class="qna-answer-date">답변일 : ${dto.a_reg_date}</div>
											</c:if>
										</div>
									</c:when>
									<c:otherwise>
										<div class="qna-no-answer">아직 관리자 답변이 등록되지 않았습니다.</div>
									</c:otherwise>
								</c:choose>
								<!-- 수정 / 삭제 -->
								<div class="qna-actions">
								<!-- 본인 글만 수정 -->
								<c:if test="${sessionScope.member.memberIdx == dto.memberIdx}">
									<button type="button" class="qna-action-btn" onclick="location.href='${pageContext.request.contextPath}/community/qna/update?qna_num=${dto.qna_num}&page=${page}';">수정</button>
								</c:if>
								<!-- 본인 글 또는 관리자 삭제 -->
								<c:if test="${sessionScope.member.memberIdx == dto.memberIdx|| sessionScope.member.userLevel >= 100}">
									<button type="button" class="qna-action-btn delete" onclick="deleteOk(${dto.qna_num});">삭제</button>
								</c:if>
							</div>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
					<div class="qna-empty">등록된 문의글이 없습니다.</div>
			</c:otherwise>
			</c:choose>
			</div>

			<div class="row board-list-footer">
				<div class="col">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/qna/qnaList';" title="새로고침"><i class="bi bi-arrow-counterclockwise"></i></button>
				</div>
				<div class="col-6 d-flex justify-content-center">
					<form class="row" name="searchForm">
						<div class="col-auto p-1">
							<select name="schType" class="form-select">
								<option value="all" ${schType=="all"?"selected":""}>제목+내용</option>
								<option value="userName" ${schType=="userName"?"selected":""}>작성자</option>
								<option value="q_title" ${schType=="q_title"?"selected":""}>제목</option>
								<option value="q_question" ${schType=="q_question"?"selected":""}>내용</option>
							</select>
						</div>
						<div class="col-auto p-1">
							<input type="text" name="kwd" value="${kwd}" class="form-control">
						</div>
						<div class="col-auto p-1">
							<button type="button" class="btn btn-light" onclick="searchList()"> <i class="bi bi-search"></i> </button>
						</div>
					</form>
				</div>
				
				<div class="col text-end">
					<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/qna/write';">문의하기</button>
				</div>
			</div>
			<div class="board-number">
				${dataCount == 0 ? "" : paging}
			</div>
	</main>
<script type="text/javascript">
    function deleteOk(qna_num) {
        if (!confirm('게시글을 삭제 하시겠습니까?')) {
            return;
        }

        const url ='${pageContext.request.contextPath}/community/qna/delete'+ '?qna_num=' + qna_num + '&page=${page}';
        location.href = url;
    }

    function filterQna(type, button) {
        document.querySelectorAll('.qna-category button').forEach(function(btn) {
            btn.classList.remove('active');
        });
        button.classList.add('active');

        document.querySelectorAll('.qna-item').forEach(function(item) {
            const qtype = item.getAttribute('data-qtype');
            if(qtype === type) {
                item.style.display = '';
            } else {
                item.style.display = 'none';
            }
        });
    }
    
	// 아코디언 열기 / 닫기
	function toggleQna(question) {
		const answerBox = question.nextElementSibling;
		const isOpen = question.classList.contains('open');
		
		// 다른 질문 닫기
		document.querySelectorAll('.qna-question.open').forEach(function(el) {
				el.classList.remove('open');
		});
		
		document.querySelectorAll('.qna-answer-box.open').forEach(function(el) {
			el.classList.remove('open');
		});

		// 현재 질문 열기
		if(!isOpen) {
			question.classList.add('open');
			answerBox.classList.add('open');
		}
	}
	// 페이지 처음 로딩 시 문의(0)만 표시
	document.addEventListener('DOMContentLoaded', function() {
		const defaultButton = document.querySelector('.qna-category button[data-type="0"]');

		if(defaultButton) {
			filterQna('0', defaultButton);
		}
	});
	
	// 검색 엔터
	document.addEventListener('DOMContentLoaded', () => {
		const inputEL = document.querySelector('form input[name=kwd]'); 
		inputEL.addEventListener('keydown', function (evt) {
			if(evt.key === 'Enter') {
				evt.preventDefault();
				searchList();
			}
		});
	});

	function searchList() {
		const f = document.searchForm;
		if(! f.kwd.value.trim()) {
			return;
		}
		
		const formData = new FormData(f);
		let params = new URLSearchParams(formData).toString();
		
		let url = '${pageContext.request.contextPath}/community/qna/qnaList';
		location.href = url + '?' + params;
	}
</script>

	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />


</body>

</html>