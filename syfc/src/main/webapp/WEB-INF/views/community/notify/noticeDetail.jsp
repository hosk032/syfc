<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>쌍용축구예약 - 게시글 상세</title>

    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/dist/css/community/boardList.css" />

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/dist/css/community/boardDetail.css" />
</head>
<body>

    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="board-container my-4">

        <aside class="community-side-menu">

            <div class="side-menu-title">
                커뮤니티
            </div>

            <a href="${pageContext.request.contextPath}/community/notify/noticeList">
                공지사항
            </a>

            <a href="${pageContext.request.contextPath}/community/board/noticeList" class="active">
                자유 게시판
            </a>

            <a href="${pageContext.request.contextPath}/community/qna/qnaList">
                문의/신고 게시판
            </a>

        </aside>

        <section class="board-detail-area">

            <div class="detail-top">
                <h3>자유 게시판</h3>
                <a href="${pageContext.request.contextPath}/community/board/noticeList"
                   class="list-btn">
                    목록
                </a>

            </div>

            <div class="detail-box">

                <div class="detail-title">

                    <h4>
                        <c:out value="${dto.b_subject}" />
                    </h4>

                </div>

                <div class="detail-info">

                    <span>
                        작성자 : <c:out value="${dto.userName}" />
                    </span>

                    <span>
                        ${dto.b_reg_date}
                    </span>

                    <span>
                        조회 ${dto.b_hitCount}
                    </span>

                </div>

                <div class="detail-content">
                    <c:out value="${dto.b_content}" />
                </div>

                <div class="detail-like">

                    <button type="button" class="btn btn-outline-primary btnSendBoardLike" title="좋아요">
                        <i class="bi ${isUserLiked ? 'bi-hand-thumbs-up-fill' : 'bi-hand-thumbs-up'}"></i>
                        <span id="likeCount"> ${dto.boardLikeCount} </span>
                    </button>

                </div>

                <div class="detail-navigation">

                    <div class="detail-navigation-row">

                        <span class="navigation-label">
                            이전글
                        </span>
                        <c:choose>
                            <c:when test="${not empty prevDto}">
                                <a href="${pageContext.request.contextPath}/community/notify/noticeDetail?${query}&bnum=${prevDto.bnum}" class="navigation-link">
                                    <c:out value="${prevDto.b_subject}" />
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="navigation-empty">
                                    이전글이 없습니다.
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="detail-navigation-row">
                        <span class="navigation-label">
                            다음글
                        </span>
                        <c:choose>
                            <c:when test="${not empty nextDto}">
                                <a href="${pageContext.request.contextPath}/community/notify/noticeDetail?${query}&bnum=${nextDto.bnum}" class="navigation-link">
                                    <c:out value="${nextDto.b_subject}" />
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="navigation-empty">
                                    다음글이 없습니다.
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>

                <div class="detail-actions">

                    <div class="detail-actions-left">
                        <c:if test="${sessionScope.member.memberIdx == dto.memberIdx}">
                            <button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/update?bnum=${dto.bnum}&page=${page}';">수정</button>
                        </c:if>
                        
                        <c:if test="${sessionScope.member.memberIdx == dto.memberIdx || sessionScope.member.userLevel >= 51}">
                            <button type="button"class="btn btn-light"onclick="deleteOk()">삭제</button>
                        </c:if>
                    </div>

                    <div class="detail-actions-right">
                        <button type="button"
                                class="btn btn-light"
                                onclick="location.href='${pageContext.request.contextPath}/community/board/noticeList?${query}';">
                            리스트
                        </button>

                    </div>

                </div>

            </div>

            <div id="replyArea"
                 data-bnum="${dto.bnum}">
            </div>

        </section>
    </div>

    <c:if test="${sessionScope.member.memberIdx == dto.memberIdx || sessionScope.member.userLevel >= 51}">
        <script type="text/javascript">
            function deleteOk() {
                if (confirm('게시글을 삭제 하시겠습니까?')) {
                    const params = 'bnum=${dto.bnum}&${query}';
                    const url ='${pageContext.request.contextPath}/community/board/delete?'+ params;
                    location.href = url;
                }
            }

        </script>
    </c:if>
<script type="text/javascript">
$(function(){
	$('button.btnSendBoardLike').click(function(){
		const $i = $(this).find('i');
		let userLiked = $i.hasClass('bi-hand-thumbs-up-fill');
		let msg = userLiked ? '게시글 공감을 취소하시겠습니까 ? ' : '게시글에 공감하시겠습니까 ? ';
		
		if(! confirm(msg)) {
			return false;
		}
		
		let url = '${pageContext.request.contextPath}/community/board/insertBoardLike';
		let bnum = '${dto.bnum}';
		let params = {bnum:bnum, userLiked:userLiked};
		
		$.ajax({
			type: 'post',
			url: url,
			data: params,
			dataType: 'json',
			success: function(data) {
				if(data.state === 'true') {
					if(userLiked) {
						$i.removeClass('bi-hand-thumbs-up-fill').addClass('bi-hand-thumbs-up');
					} else {
						$i.removeClass('bi-hand-thumbs-up').addClass('bi-hand-thumbs-up-fill');					
					}
					
					let count = data.boardLikeCount;
					$('#likeCount').text(count);
					
				} else if(data.state === 'liked') {
					alert('게시글 공감은 한번만 가능합니다.');				
				} else if(data.state === 'false') {
					alert('게시글 공감 여부 처리가 실패했습니다.');
				}
		},
	       error: function(xhr, status, error) {

               console.log(xhr.responseText);
               console.log(status);
               console.log(error);

               alert('공감 처리 중 오류가 발생했습니다.');
		}
		});
	});
})
</script>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <script>

        const contextPath = '${pageContext.request.contextPath}';

    </script>

    <script src="${pageContext.request.contextPath}/dist/js/community/reply.js"></script>

</body>

</html>