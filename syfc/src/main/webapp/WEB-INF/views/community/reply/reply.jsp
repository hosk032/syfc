<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"  %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/reply.css" />

<div class="reply-container">

    <div class="reply-header">
        <h5>댓글</h5>
        <span>${replyCount}개</span>
    </div>

    <!-- 댓글 목록 -->
    <div class="reply-list" data-offset="${offset}" data-size="${size}" data-total-count="${replyCount}">
        <c:choose>
            <c:when test="${empty replyList}">
				<c:if test="${offset == 0}">
	                <div class="reply-empty">
	                    등록된 댓글이 없습니다.
	                </div>
            	</c:if>
            </c:when>

            <c:otherwise>
                <c:forEach var="reply" items="${replyList}">
                    <div class="reply-item" data-reply-num="${reply.reply_num}">
                        <div class="reply-info">
                            <strong>
                                <c:out value="${reply.userName}"/>
                            </strong>
                            <span>
                                ${reply.r_reg_date}
                            </span>
                        </div>
                        <div class="reply-content">
                            <c:out value="${reply.r_content}"/>
                        </div>

                        <!-- 본인 댓글이면 수정/삭제 -->
                        <c:if test="${sessionScope.member.memberIdx == reply.memberIdx || sessionScope.member.userLevel >= 51}">
                            <div class="reply-buttons">
                                <c:if test="${sessionScope.member.memberIdx == reply.memberIdx}">
                                    <button type="button" class="btn btn-sm btn-light" onclick="editReply(${reply.reply_num})">수정</button>
                                </c:if>
                                <button type="button" class="btn btn-sm btn-light" onclick="deleteReply(${reply.reply_num})"> 삭제</button>
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
        
		<c:if test="${replyCount > offset + size}">
		    <div class="reply-more-wrap">
		        <button type="button" class="btn btn-light reply-more-btn">댓글 더보기</button>
		    </div>
		</c:if>
    </div>
    
     <!-- 댓글 작성 -->
    <c:if test="${not empty sessionScope.member}">
        <form id="replyForm">
            <input type="hidden" name="bnum" value="${bnum}"/>
            	<div class="reply-write" style="padding: 10px;">
	                <textarea name="r_content" class="form-control" placeholder="댓글을 입력하세요." required
	                style="height: 100px; max-height: 200px; resize: none; overflow-y: auto"></textarea>
	                <div class="d-flex justify-content-end">
					    <button type="submit" class="btn btn-primary mt-2">등록</button>
					</div>
	            </div>
        </form>
    </c:if>
    
    
</div>