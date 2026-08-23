<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Spring</title>
<jsp:include page="/WEB-INF/views/layout/headerResources.jsp"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/community/board.css" type="text/css">
</head>
<body>

<header>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"/>
</header>


<main class="writeContainer">
    <div class="writeHeader">
      <h2 class="writeTitle"><i class="bi bi-pencil-square me-2"></i>문의/신고 작성</h2>
    </div>

    <form class="writeForm" name="writeForm" method="post" enctype="multipart/form-data">
      <div class="formGroup">
        <label for="boardCategory" class="formLabel">카테고리</label>
        <div class="formInputWrap">
	          <select id="qType" name="q_type" class="formControl selectControl" required>
	            <option value="0" ${empty dto.q_type || dto.q_type == 0 ? "selected" : ""}> 문의 </option>
	            <option value="1" ${dto.q_type == 1 ? "selected" : ""}> 신고 </option>
	        </select>
        </div>
      </div>

      <div class="formGroup">
        <label for="boardTitle" class="formLabel">제 목</label>
        <div class="formInputWrap">
          <input type="text" id="boardTitle" name="q_title" class="formControl" value="${dto.q_title}" placeholder="제목을 입력해 주세요." required/>
        </div>
      </div>


      <div class="formGroup">
        <label for="boardAuthor" class="formLabel">작성자명</label>
        <div class="formInputWrap">
          <input type="text" id="boardAuthor" name="auther" value="${sessionScope.member.userName}" class="formControl authorControl" readonly/>
        </div>
      </div>

      <div class="formGroup alignTop">
        <label for="boardContent" class="formLabel">내 용</label>
        <div class="formInputWrap">
          <textarea id="boardContent" name="q_question" class="formControl textareaControl" placeholder="내용을 작성해 주세요." required>${dto.q_question}</textarea>
        </div>
      </div>

      <!-- 첨부파일 -->
      <div class="formGroup">
        <label for="boardFile" class="formLabel">첨부파일</label>
        <div class="formInputWrap">
          <input type="file" id="boardFile" name="file" class="fileControl" />
        </div>
      </div>

      <div class="formActions">
        <button type="button" class="btn btnSubmit" onclick="sendOk();">${mode=="update" ? "수정완료" : "등록완료"}&nbsp;</button>
        <button type="reset" class="btn btnReset">다시입력</button>
        <button type="button" class="btn btnCancel" onclick="location.href='${pageContext.request.contextPath}/community/qna/qnaList';">${mode=="update" ? "수정취소" : "등록취소"}&nbsp;</button>
        <c:if test="${mode == 'update' }">
			<input type="hidden" name="qna_num" value="${dto.qna_num}">
			<input type="hidden" name="page" value="${page}">
		</c:if>
      </div>
    </form>
  </main>

<script type="text/javascript">
function sendOk() {
	const f = document.writeForm;
	let str;
	
	str = f.q_title.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.q_title.focus();
		return;
	}

	str = f.q_question.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.q_question.focus();
		return;
	}
	
	f.action = '${pageContext.request.contextPath}/community/qna/${mode}';
	f.submit();
}
</script>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>


</body>
</html>