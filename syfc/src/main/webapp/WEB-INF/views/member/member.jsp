<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>쌍용축구예약 - 회원가입</title>
    
    <!-- 1. 공통 CSS/CDN/폰트 리소스 조립 -->
    <jsp:include page="/WEB-INF/views/layout/headerResources.jsp" />

    <!-- 회원가입 전용 CSS (dist/css/main/register.css) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/main/register.css" />

    <!-- 카카오/다음 우편번호 서비스 API CDN -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script defer>
    const contextPath = "${pageContext.request.contextPath}";
	</script> 
    
</head>
<body>

    <!-- 상단 헤더 조립 -->
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="register-container my-4">
        <!-- 헤더 -->
        <div class="register-header">
            <h1>쌍용축구<span>예약</span></h1>
            <p>축구 경기 관리 시스템 회원가입</p>
        </div>

        <!-- 파일 첨부를 위해 enctype="multipart/form-data" 속성 추가 -->
        <form action="${pageContext.request.contextPath}/member/account" method="POST" id="joinForm" enctype="multipart/form-data">
            
            <!-- ★ [신규 추가] 0. 프로필 사진 업로드 영역 ★ -->
            <div class="form-section text-center">
                <div class="profile-avatar-wrapper mx-auto mb-2">
                    <div id="profilePreview" class="profile-avatar-preview">
                        <i class="bi bi-person-fill"></i>
                    </div>
                    <label for="profileImageInput" class="profile-upload-btn" title="프로필 사진 선택">
                        <i class="bi bi-camera-fill"></i>
                    </label>
                </div>
                <input type="file" class="d-none" id="profileImageInput" name="profile_photo" accept="image/*" onchange="previewProfileImage(this)">
                <span class="text-muted extra-small d-block">프로필 사진을 등록해 주세요 (선택)</span>
            </div>

            <!-- 1. 계정 정보 -->
            <div class="form-section">
                <div class="section-title">⚽ 계정 정보</div>
                <div class="form-grid">
                    <div class="input-group full-width">
                        <label for="userId">아이디</label>
                        <div class="input-wrapper">
                            <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
                            <button type="button" id="userIdCheckBtn" class="btn-sub">중복확인</button>
                            <span id="userIdMessage"></span>
                        </div>
                    </div>
                    <div class="input-group">
                        <label for="userPwd">비밀번호</label>
                        <input type="password" id="userPwd" name="userPwd" placeholder="영문, 숫자 포함 8자 이상" required>
                    </div>
                    <div class="input-group">
                        <label for="userPwdCheck">비밀번호 확인</label>
                        <input type="password" id="userPwdCheck" placeholder="비밀번호 재입력" required>
                        <span id="pwdMatchMessage" class="msg"></span>
                    </div>
                </div>
            </div>

            <!-- 2. 인적 사항 -->
            <div class="form-section">
                <div class="section-title">👤 개인 정보</div>
                <div class="form-grid">
                    <div class="input-group">
                        <label for="userName">이름 </label>
                        <input type="text" id="userName" name="userName" placeholder="홍길동" required>
                    </div>
                    <div class="input-group">
                        <label for="birth">생년월일</label>
                        <input type="date" id="birth" name="birth" required>
                    </div>
                    <div class="input-group full-width">
                        <label>성별 </label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="genderM" name="gender" value="1" checked>
                                <label for="genderM">남성</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="genderF" name="gender" value="2">
                                <label for="genderF">여성</label>
                            </div>
                        </div>
                    </div>
                    <div class="input-group">
                        <label for="email">이메일 </label>
                        <input type="email" id="email" name="email" placeholder="example@football.com" required>
                    </div>
                    <div class="input-group">
                        <label for="tel">연락처</label>
                        <input type="tel" id="tel" name="tel" placeholder="01012345678 ('-' 제외)">
                    </div>
                </div>
            </div>

            <!-- 3. 주소 정보 (다음/카카오 주소 API 연동) -->
            <div class="form-section">
                <div class="section-title">📍 주소 정보</div>
                <div class="form-grid">
                    <div class="input-group full-width">
                        <label for="zipcode">우편번호 </label>
                        <div class="input-wrapper">
                            <input type="text" id="zipcode" name="zip" placeholder="우편번호" readonly required>
                            <button type="button" class="btn-sub" onclick="execDaumPostcode()">주소 검색</button>
                        </div>
                    </div>
                    <div class="input-group full-width">
                        <label for="address1">기본 주소 </label>
                        <input type="text" id="address1" name="addr1" placeholder="기본 주소" readonly required>
                    </div>
                    <div class="input-group full-width">
                        <label for="address2">상세 주소 </label>
                        <input type="text" id="address2" name="addr2" placeholder="상세 주소를 입력하세요">
                    </div>
                </div>
            </div>

            <!-- 4. 축구 프로필 -->
            <div class="form-section">
                <div class="section-title">🏃 축구 프로필</div>
                <div class="form-grid">
                    <div class="input-group full-width">
                        <label>선호 포지션</label>
                        <div class="radio-group">
                            <div class="radio-option">
                                <input type="radio" id="posGk" name="pref_position" value="1">
                                <label for="posGk">GK</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="posDf" name="pref_position" value="2">
                                <label for="posDf">DF</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="posMf" name="pref_position" value="3" checked>
                                <label for="posMf">MF</label>
                            </div>
                            <div class="radio-option">
                                <input type="radio" id="posFw" name="pref_position" value="4">
                                <label for="posFw">FW</label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 가입하기 버튼 -->
            <button type="submit" class="btn-submit">회원가입 완료</button>
        </form>
    </div>

    <!-- 하단 푸터 조립 -->
    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <!-- 회원가입 전용 JS 연결 (dist/js/main/register.js) -->
    <script src="${pageContext.request.contextPath}/dist/js/main/register.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/common/footer.js"></script>
       

</body>
</html>