<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
  <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

  <!-- 다음/카카오 주소 검색 API CDN -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

  <!-- 2. 관리자 경기장 등록 전용 CSS 연결 (dist/css/admin/board3.css) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/admin/board3.css" />
</head>
<body>

  <!-- 상단 헤더 조립 -->
  <jsp:include page="/WEB-INF/views/layout/header.jsp" />

  <main class="writeContainer">
    <div class="writeHeader">
      <h2 class="writeTitle"><i class="bi bi-geo-alt-fill me-2"></i>경기장 등록</h2>
      <p class="writeDesc">경기장 위치, 이용 가능 시간 및 요금을 등록하고 상태를 관리해 주세요.</p>
    </div>

    <form class="writeForm" action="${pageContext.request.contextPath}/admin/write3" method="post" enctype="multipart/form-data">
      
      <!-- 경기장명 -->
      <div class="formGroup">
        <label for="stadiumName" class="formLabel">경기장명</label>
        <div class="formInputWrap">
          <input 
            type="text" 
            id="stadiumName" 
            name="stadiumName" 
            class="formControl" 
            placeholder="경기장 이름을 입력해 주세요. (예: 잠실 종합운동장 보조경기장)" 
            required 
          />
        </div>
      </div>

      <!-- 주소 및 위치 -->
      <div class="formGroup alignTop">
        <label class="formLabel">주소 및 위치</label>
        <div class="formInputWrap">
          <div class="addressGroup">
            <div class="addressSearchRow">
              <input 
                type="text" 
                id="stadiumAddress" 
                name="stadiumAddress" 
                class="formControl" 
                placeholder="경기장 주소를 검색하세요." 
                readonly
                required 
              />
              <button type="button" class="btnAddressSearch" onclick="execDaumPostcode()">경기장/주소 검색</button>
            </div>
            
            <input 
              type="text" 
              id="stadiumDetailAddress" 
              name="stadiumDetailAddress" 
              class="formControl" 
              placeholder="상세 위치 정보 (예: A구장, 인조잔디 2구장 등)" 
            />

            <div class="mapPreviewBox" id="mapContainer">
              <i class="bi bi-geo-alt fs-2 text-secondary mb-1"></i>
              <span>주소 검색 시 지도 상 위치 정보가 보여지는 영역입니다.</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 이용 가능 시간 -->
      <div class="formGroup alignTop">
        <label class="formLabel">이용 가능 시간</label>
        <div class="formInputWrap">
          <div class="timeGroup">
            <div class="timeRangeRow">
              <input type="time" id="stadiumStartTime" name="stadiumStartTime" class="formControl timeInput" value="06:00" required />
              <span class="timeSeparator">~</span>
              <input type="time" id="stadiumEndTime" name="stadiumEndTime" class="formControl timeInput" value="22:00" required />
            </div>
            <input 
              type="text" 
              id="stadiumTimeNotice" 
              name="stadiumTimeNotice" 
              class="formControl" 
              placeholder="운영 시간 관련 참고사항 (예: 야간 조명 22:00까지, 주말 08:00 오픈)" 
            />
          </div>
        </div>
      </div>

      <!-- 이용 요금 -->
      <div class="formGroup alignTop">
        <label class="formLabel">이용 요금</label>
        <div class="formInputWrap">
          <div class="priceGroup">
            <div class="priceInputRow">
              <input 
                type="text" 
                id="stadiumPrice" 
                name="stadiumPrice" 
                class="formControl" 
                placeholder="예: 50,000" 
                required 
              />
              <span class="unitText">원 / 시간당</span>
            </div>
            <input 
              type="text" 
              id="stadiumPriceNotice" 
              name="stadiumPriceNotice" 
              class="formControl" 
              placeholder="요금 관련 부가사항 (예: 야간 조명비 1만원 추가, 주말/공휴일 20% 할증)" 
            />
          </div>
        </div>
      </div>

      <!-- 이용 가능 여부 -->
      <div class="formGroup">
        <label class="formLabel">이용 가능 여부</label>
        <div class="formInputWrap">
          <div class="statusRadioGroup">
            <label class="radioLabel">
              <input type="radio" name="stadiumStatus" value="AVAILABLE" checked />
              경기가능
            </label>
            <label class="radioLabel">
              <input type="radio" name="stadiumStatus" value="UNAVAILABLE" />
              경기불가
            </label>
            <span id="statusBadge" class="badgeStatus badgeAvailable">경기가능 상태</span>
          </div>
        </div>
      </div>

      <!-- 경기장 사진 -->
      <div class="formGroup alignTop">
        <label for="stadiumImage" class="formLabel">경기장 사진</label>
        <div class="formInputWrap">
          <div class="imageUploadWrap">
            <input type="file" id="stadiumImage" name="stadiumImage" class="fileControl" accept="image/*" required />
            <div class="previewBox" id="previewBox">
              <img id="imagePreview" src="" alt="경기장 미리보기" />
            </div>
          </div>
        </div>
      </div>

      <!-- 하단 버튼 -->
      <div class="formActions">
        <button type="submit" class="btn btnSubmit">경기장 등록완료</button>
        <button type="reset" class="btn btnReset">다시입력</button>
        <button type="button" class="btn btnCancel" onclick="history.back()">등록취소</button>
      </div>

    </form>
  </main>

  <!-- 하단 푸터 조립 -->
  <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

  <!-- 3. 관리자 전용 JS 연결 (dist/js/admin/board3.js) -->
  <script src="${pageContext.request.contextPath}/dist/js/admin/board3.js"></script>
</body>
</html>