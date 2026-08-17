<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>쌍용축구예약 - 게시글 상세</title>

    <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 2. 게시판 전용 CSS 연결 (dist/css/community/ 하위 경로 적용) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardList.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/boardDetail.css" />
</head>
<body>

    <!-- 상단 헤더/네비게이션 조립 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="board-container my-4">
        <!-- 왼쪽 서브 메뉴 (사이드바) -->
        <aside class="community-side-menu">
            <div class="side-menu-title">커뮤니티</div>
            <a href="${pageContext.request.contextPath}/community/notify/noticeList">공지사항</a>
            <a href="${pageContext.request.contextPath}/community/board/boardList" class="active">자유 게시판</a>
            <a href="${pageContext.request.contextPath}/community/qna/qnaList">문의/신고 게시판</a>
        </aside>

        <!-- 오른쪽 상세 본문 영역 -->
        <section class="board-detail-area">
            <div class="detail-top">
                <h3>자유 게시판</h3>
                <a href="${pageContext.request.contextPath}/community/board/boardList" class="list-btn">목록</a>
            </div>

            <div class="detail-box">
                    <h4><c:out value="${dto.b_subject}"/></h4>

                	<table>
	                	<tr>
		                    <td>
		            		이름 : ${dto.userName}
		            		</td>
		            		<td align="right">
								${dto.b_reg_date} | 조회 ${dto.b_hitCount}
							</td>
	                	</tr>
                	
	                	<tr>
		                    <td>
		            		${dto.b_content}
		            		</td>
	                	</tr>
	                	
	                	<tr>
							<td colspan="2" class="text-center p-3">
								<button type="button" class="btn btn-outline-primary btnSendBoardLike" title="좋아요"><i class="bi ${isUserLiked ? 'bi-hand-thumbs-up-fill' : 'bi-hand-thumbs-up'}"></i>&nbsp;&nbsp;<span id="likeCount">${dto.boardLikeCount}</span></button>
							</td>
						</tr>
												
						<tr>
							<td colspan="2">
								이전글 :
								<c:if test="${not empty prevDto}">
									<a href="${pageContext.request.contextPath}/community/board/boardDetail?${query}&bnum=${prevDto.bnum}"><c:out value="${prevDto.b_subject}"/></a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								다음글 :
								<c:if test="${not empty nextDto}">
									<a href="${pageContext.request.contextPath}/community/board/boardDetail?${query}&bnum=${nextDto.bnum}"><c:out value="${nextDto.b_subject}"/></a>
								</c:if>
							</td>
						</tr>
	                	
                	</table>
            
            <!-- 
                <div class="detail-title">
                </div>
                <div class="detail-info">
                </div>
                <div class="detail-content">
                </div>
             -->
                	
					<table class="table table-borderless mb-2">
						<tr>
							<td width="50%">
								<c:choose>
									<c:when test="${sessionScope.member.memberIdx == dto.memberIdx}">
										<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/update?bnum=${dto.bnum}&page=${page}';">수정</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light" disabled>수정</button>
									</c:otherwise>
								</c:choose>
								
								<c:choose>
									<c:when test="${sessionScope.member.memberIdx == dto.memberIdx || sessionScope.member.userLevel >= 51}">
										<button type="button" class="btn btn-light" onclick="deleteOk()">삭제</button>
									</c:when>
									<c:otherwise>
										<button type="button" class="btn btn-light" disabled>삭제</button>
									</c:otherwise>
								</c:choose>
							
								
					    		
							</td>
							<td class="text-end">
								<button type="button" class="btn btn-light" onclick="location.href='${pageContext.request.contextPath}/community/board/boardList?${query}';">리스트</button>
							</td>
						</tr>
					</table>
                	
            </div>
            <!-- 댓글 -->
            <div id="replyArea"
		    	data-bnum="${dto.bnum}">
			</div>
            
            
        </section>
    </div>

<c:if test="${sessionScope.member.memberIdx == dto.memberIdx || sessionScope.member.userLevel >= 51}">
	<script type="text/javascript">
		function deleteOk() {
			if(confirm('게시글을 삭제 하시겠습니까?')) {
				const params = 'bnum=${dto.bnum}&${query}';
				const url = '${pageContext.request.contextPath}/community/board/delete?' + params;
				location.href = url;
			}
		}
	</script>
</c:if>

    <!-- 하단 푸터 조립 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <!-- 3. 게시글 상세 전용 JS 연결 (dist/js/community/boardDetail.js) -->
    <!-- 
    <script src="${pageContext.request.contextPath}/dist/js/community/boardDetail.js"></script>
     -->
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>

<script src="${pageContext.request.contextPath}/dist/js/community/reply.js"></script>
     
</body>
</html>