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
      <h2 class="writeTitle"><i class="bi bi-pencil-square me-2"></i>게시글 작성</h2>
      <p class="writeDesc">구단 모집 및 자유로운 축구 이야기를 작성해 보세요.</p>
    </div>

    <form class="writeForm" name="writeForm" method="post" enctype="multipart/form-data">
      <!-- 카테고리 -->
      <div class="formGroup">
        <label for="boardCategory" class="formLabel">카테고리</label>
        <div class="formInputWrap">
          <select id="boardCategory" name="category" class="formControl selectControl" required>
            <option value="" disabled selected>카테고리를 선택하세요</option>
            <option value="notice">공지사항</option>
            <option value="free">자유게시판</option>
            <option value="inquiry">문의게시판</option>
          </select>
        </div>
      </div>

      <!-- 제목 -->
      <div class="formGroup">
        <label for="boardTitle" class="formLabel">제 목</label>
        <div class="formInputWrap">
          <input 
            type="text" 
            id="boardTitle" 
            name="b_subject" 
            class="formControl" 
            placeholder="제목을 입력해 주세요." 
            required 
          />
        </div>
      </div>

      <!-- 작성자명 (읽기 전용) -->
      <div class="formGroup">
        <label for="boardAuthor" class="formLabel">작성자명</label>
        <div class="formInputWrap">
          <input 
            type="text" 
            id="boardAuthor" 
            name="auther" 
            class="formControl authorControl" 
            value="admin" 
            readonly 
          />
        </div>
      </div>

      <!-- 내용 -->
      <div class="formGroup alignTop">
        <label for="boardContent" class="formLabel">내 용</label>
        <div class="formInputWrap">
          <textarea 
            id="boardContent" 
            name="b_content" 
            class="formControl textareaControl" 
            placeholder="내용을 작성해 주세요. (매치 신청 시 일시, 장소, 실력대를 적어주시면 좋습니다)" 
            required
          ></textarea>
        </div>
      </div>

      <!-- 첨부파일 -->
      <div class="formGroup">
        <label for="boardFile" class="formLabel">첨부파일</label>
        <div class="formInputWrap">
          <input type="file" id="boardFile" name="file" class="fileControl" />
        </div>
      </div>

      <!-- 하단 버튼 -->
      <div class="formActions">
        <button type="button" class="btn btnSubmit" onclick="sendOk();">${mode=="update" ? "수정완료" : "등록완료"}&nbsp;</button>
        <button type="reset" class="btn btnReset">다시입력</button>
        <button type="button" class="btn btnCancel" onclick="history.back()">등록취소</button>
      </div>
    </form>
  </main>


<script type="text/javascript">
function sendOk() {
	const f = document.writeForm;
	let str;
	
	str = f.b_subject.value.trim();
	if( ! str ) {
		alert('제목을 입력하세요. ');
		f.b_subject.focus();
		return;
	}

	str = f.b_content.value.trim();
	if( ! str ) {
		alert('내용을 입력하세요. ');
		f.b_content.focus();
		return;
	}
	
	
	f.action = '${pageContext.request.contextPath}/community/board/write';
	f.submit();
}
</script>


<footer>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"/>
</footer>


</body>
</html>