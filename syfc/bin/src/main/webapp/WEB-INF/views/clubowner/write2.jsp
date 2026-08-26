<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <!-- 2. 구단 등록 전용 CSS 연결 (dist/css/clubowner/board2.css) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/clubowner/board2.css" />
</head>
<body>

  <!-- 상단 헤더 조립 -->
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />

  <main class="writeContainer">
    <div class="writeHeader">
      <h2 class="writeTitle"><i class="bi bi-shield-plus me-2"></i>구단 등록</h2>
      <p class="writeDesc">새로운 축구 구단을 등록하고 함께 뛸 멋진 팀원들을 소개해 주세요.</p>
    </div>

    <form class="writeForm" action="${pageContext.request.contextPath}/clubowner/write2" method="post" enctype="multipart/form-data">
      
      <!-- 구단명 -->
      <div class="formGroup">
        <label for="clubName" class="formLabel">구단명</label>
        <div class="formInputWrap clubNameWrap">
          <div class="clubNameInputGroup">
            <input 
              type="text" 
              id="clubName" 
              name="clubName" 
              class="formControl" 
              placeholder="구단명을 입력해 주세요. (예: FC 쌍용)" 
              required 
            />
            <button type="button" id="btnCheckClubName" class="btnCheck">중복 확인</button>
          </div>
          <span id="clubNameMsg" class="checkMsg"></span>
        </div>
      </div>

      <!-- 구단 마크(엠블럼) -->
      <div class="formGroup alignTop">
        <label for="clubLogo" class="formLabel">구단 마크</label>
        <div class="formInputWrap logoWrap">
          <input type="file" id="clubLogo" name="clubLogo" class="fileControl" accept="image/*" required />
          <div class="previewBox" id="previewBox">
            <img id="logoPreview" src="" alt="미리보기" />
          </div>
        </div>
      </div>

      <!-- 구단 소개글 -->
      <div class="formGroup alignTop">
        <label for="clubDesc" class="formLabel">구단 소개글</label>
        <div class="formInputWrap">
          <textarea 
            id="clubDesc" 
            name="clubDesc" 
            class="formControl textareaControl" 
            placeholder="구단 목표, 홈구장, 활동 요일 및 연령대 등 구단을 자유롭게 소개해 주세요." 
            required
          ></textarea>
        </div>
      </div>

      <!-- 등록 선수 -->
      <div class="formGroup alignTop">
        <label class="formLabel">등록 선수</label>
        <div class="formInputWrap playerListWrap">
          <div class="playerList" id="playerList"></div>
          
          <button type="button" class="btn btnAddPlayer" id="btnAddPlayer">
            <i class="bi bi-plus-circle me-1"></i>선수 추가
          </button>
        </div>
      </div>

      <!-- 하단 버튼 -->
      <div class="formActions">
        <button type="submit" class="btn btnSubmit">구단 등록완료</button>
        <button type="reset" class="btn btnReset">다시입력</button>
        <button type="button" class="btn btnCancel" onclick="history.back()">등록취소</button>
      </div>

    </form>
  </main>

  <!-- 하단 푸터 조립 -->
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

  <!-- 3. 구단 등록 전용 JS 연결 (dist/js/clubowner/board2.js) -->
  <script src="${pageContext.request.contextPath}/dist/js/clubowner/board2.js"></script>
</body>
</html>