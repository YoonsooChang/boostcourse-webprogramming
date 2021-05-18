<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Object sessionUserNullable = session.getAttribute("user");
String userEmail = (sessionUserNullable != null) ? sessionUserNullable.toString() : "";
%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta name="description"
	content="네이버 예약, 네이버 예약이 연동된 곳 어디서나 바로 예약하고, 네이버 예약 홈(나의예약)에서 모두 관리할 수 있습니다.">
<meta name="viewport"
	content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
<title>네이버 예약</title>
<link href="/reservation/css/style.css" rel="stylesheet">

</head>

<body>
	<input type="hidden" id="user-email" value=<%=userEmail%>>

	<div id="container">
		<div class="header">
			<header class="header_tit">
				<h1 class="logo">
					<a href="." class="lnk_logo" title="네이버"> <span
						class="spr_bi ico_n_logo">네이버</span>
					</a> <a href="." class="lnk_logo" title="예약"> <span
						class="spr_bi ico_bk_logo">예약</span>
					</a>
				</h1>
				<a href="bookinglogin" id="btn-my-session-off" class="btn_my"> <span
					class="viewReservation" title="예약확인">예약확인</span>
				</a> <a href="myreservation" id="btn-my-session-on" class="btn_my">
					<span class="viewReservation"><%=userEmail%></span>
				</a>
			</header>
		</div>
		<hr>
		<div class="ct">
			<div class="section_my">
				<!-- 예약 현황 -->
				<div class="my_summary">
					<ul class="summary_board">
						<li class="item">
							<!--[D] 선택 후 .on 추가 link_summary_board --> <a
							href="javascript:void(0)" class="link_summary_board on"> <i
								class="spr_book2 ico_book2"></i> <em class="tit">전체</em> <span
								id="count-all" class="figure"></span>
						</a>
						</li>
						<li class="item"><a href="javascript:void(0)"
							class="link_summary_board"> <i class="spr_book2 ico_book_ss"></i>
								<em class="tit">이용예정</em> <span id="count-todo" class="figure"></span>
						</a></li>
						<li class="item"><a href="javascript:void(0)"
							class="link_summary_board"> <i class="spr_book2 ico_check"></i>
								<em class="tit">이용완료</em> <span id="count-done" class="figure"></span>
						</a></li>
						<li class="item"><a href="javascript:void(0)"
							class="link_summary_board"> <i class="spr_book2 ico_back"></i>
								<em class="tit">취소·환불</em> <span id="count-canceled"
								class="figure"></span>
						</a></li>
					</ul>
				</div>
				<!--// 예약 현황 -->

				<!-- 내 예약 리스트 -->
				<div id="list-wrapper" class="wrap_mylist">
					<ul class="list_cards">
						<li id="confirmed-section" class="card confirmed">
							<div class="link_booking_details">
								<div class="card_header">
									<div class="left"></div>
									<div class="middle">
										<!--[D] 예약 신청중: .ico_clock, 예약확정&이용완료: .ico_check2, 취소된 예약: .ico_cancel 추가 spr_book -->
										<i class="spr_book2 ico_check2"></i> <span class="tit">예약
											확정</span>
									</div>
									<div class="right"></div>
								</div>
							</div> <!-- 예정된 예약 -->
						</li>
						<li id="used-section" class="card used">
							<div class="link_booking_details">
								<div class="card_header">
									<div class="left"></div>
									<div class="middle">
										<i class="spr_book2 ico_check2"></i> <span class="tit">이용
											완료</span>
									</div>
									<div class="right"></div>
								</div>
							</div> <!-- 완료된 예약 -->
						</li>
						<li id="canceled-section" class="card used cancel">
							<div class="link_booking_details">
								<div class="card_header">
									<div class="left"></div>
									<div class="middle">
										<i class="spr_book2 ico_cancel"></i> <span class="tit">취소된
											예약</span>
									</div>
									<div class="right"></div>
								</div>
							</div> <!-- 취소된 예약 -->
						</li>
					</ul>
				</div>
				<!--// 내 예약 리스트 -->

				<!-- 예약 리스트 없음 -->
				<div id="err-wrapper" class="err">
					<i class="spr_book ico_info_nolist"></i>
					<h1 class="tit">예약 리스트가 없습니다</h1>
				</div>
				<!--// 예약 리스트 없음 -->
			</div>
		</div>
		<hr>
	</div>
	<footer>
		<div class="gototop">
			<a href="javascript:void(0)" class="lnk_top"> <span
				class="lnk_top_text">TOP</span>
			</a>
		</div>
		<div id="footer" class="footer">
			<p class="dsc_footer">네이버(주)는 통신판매의 당사자가 아니며, 상품의정보, 거래조건, 이용 및
				환불 등과 관련한 의무와 책임은 각 회원에게 있습니다.</p>
			<span class="copyright">© NAVER Corp.</span>
		</div>
	</footer>

	<!-- 취소 팝업 -->
	<!-- [D] 활성화 display:block, 아니오 버튼 or 닫기 버튼 클릭 시 숨김 display:none; -->
	<div id="cancel-confirm-popup" class="popup_booking_wrapper"
		style="display: none;">
		<div class="dimm_dark" style="display: block"></div>
		<div class="popup_booking refund">
			<h1 class="pop_tit">
				<span id="product-title"></span> <small id="opening-days" class="sm"></small>
			</h1>
			<div class="nomember_alert">
				<p>취소하시겠습니까?</p>
			</div>
			<div class="pop_bottom_btnarea">
				<div class="btn_gray">
					<a href="#" id="withdraw-btn" class="btn_bottom"><span>아니오</span></a>
				</div>
				<div class="btn_green">
					<a href="#" id="confirm-btn" class="btn_bottom"><span>예</span></a>
				</div>
			</div>
			<!-- 닫기 -->
			<a href="#" id="close-btn" class="popup_btn_close" title="close">
				<i class="spr_book2 ico_cls"></i>
			</a>
			<!--// 닫기 -->
		</div>
	</div>
	<!--// 취소 팝업 -->
	<script type="rv-template" id="todoItem">
		<article id="reservation-{{reservationInfoId}}" class="card_item">
		<a href="#" class="link_booking_details">
			<div class="card_body">
				<div class="left"></div>
				<div class="middle">
					<div class="card_detail">
						<em class="booking_number">No.{{reservationInfoIdPadding}}</em>
						<h4 class="tit">{{productDescription}}</h4>
						<ul class="detail">
							<li class="item"><span class="item_tit">일정</span> <em
								class="item_dsc opening">{{openingDays}} </em></li>
							<li class="item"><span class="item_tit">내역</span> <em
								class="item_dsc"> 내역이 없습니다. </em></li>
							<li class="item"><span class="item_tit">장소</span> <em
								class="item_dsc"> 내역이 없습니다. </em></li>
							<li class="item"><span class="item_tit">업체</span> <em
								class="item_dsc"> 업체명이 없습니다. </em></li>
						</ul>
						<div class="price_summary">
							<span class="price_tit">결제 예정금액</span> <em
								class="price_amount"> <span>{{totalPrice}}</span> <span
								class="unit">원</span>
							</em>
						</div>
						<!-- [D] 예약 신청중, 예약 확정 만 취소가능, 취소 버튼 클릭 시 취소 팝업 활성화 -->
						<div class="booking_cancel">
							<button id="cancelbtn-{{reservationInfoId}}" class="button">
								<span>취소</span>
							</button>
						</div>

					</div>
				</div>
				<div class="right"></div>
			</div>
			<div class="card_footer">
				<div class="left"></div>
				<div class="middle"></div>
				<div class="right"></div>
			</div>
		</a> <a href="#" class="fn fn-share1 naver-splugin btn_goto_share"
			title="공유하기"></a>
	</article>

	</script>
	<script type="rv-template" id="doneItem">
		<article id="reservation-{{reservationInfoId}}" class="card_item">
			<a href="#" class="link_booking_details">
				<div class="card_body">
					<div class="left"></div>
					<div class="middle">
						<div class="card_detail">
							<em class="booking_number">No.{{reservationInfoIdPadding}}</em>
							<h4 class="tit">{{productDescription}}</h4>
							<ul class="detail">
								<li class="item"><span class="item_tit">일정</span> <em
									class="item_dsc"> {{openingDays}} </em></li>
								<li class="item"><span class="item_tit">내역</span> <em
									class="item_dsc"> 내역이 없습니다. </em></li>
								<li class="item"><span class="item_tit">장소</span> <em
									class="item_dsc"> 내역이 없습니다. </em></li>
								<li class="item"><span class="item_tit">업체</span> <em
									class="item_dsc"> 업체명이 없습니다. </em></li>
							</ul>
							<div class="price_summary">
								<span class="price_tit">결제 예정금액</span> <em
									class="price_amount"> <span>{{totalPrice}}</span> <span
									class="unit">원</span>
								</em>
							</div>
							<div class="booking_cancel">
								<a href="/reservation/reviewWrite?user=<%=userEmail%>&product={{productId}}&reservation={{reservationInfoId}}"><button class="btn">
										<span>예매자 리뷰 남기기</span>
									</button></a>
							</div>
						</div>
					</div>
					<div class="right"></div>
				</div>
				<div class="card_footer">
					<div class="left"></div>
					<div class="middle"></div>
					<div class="right"></div>
				</div>
			</a>
		</article>

	</script>
	<script type="rv-template" id="canceledItem">
		<article id="reservation-{{reservationInfoId}}" class="card_item">
			<a href="#" class="link_booking_details">
				<div class="card_body">
					<div class="left"></div>
					<div class="middle">
						<div class="card_detail">
							<em class="booking_number">No.{{reservationInfoIdPadding}}</em>
							<h4 class="tit">{{productDescription}}</h4>
							<ul class="detail">
								<li class="item"><span class="item_tit">일정</span> <em
									class="item_dsc"> {{openingDays}} </em></li>
								<li class="item"><span class="item_tit">내역</span> <em
									class="item_dsc"> 내역이 없습니다. </em></li>
								<li class="item"><span class="item_tit">장소</span> <em
									class="item_dsc"> 내역이 없습니다. </em></li>
								<li class="item"><span class="item_tit">업체</span> <em
									class="item_dsc"> 업체명이 없습니다. </em></li>
							</ul>
							<div class="price_summary">
								<span class="price_tit">결제 예정금액</span> <em
									class="price_amount"> <span>{{totalPrice}}</span> <span
									class="unit">원</span>
								</em>
							</div>
						</div>
					</div>
					<div class="right"></div>
				</div>
				<div class="card_footer">
					<div class="left"></div>
					<div class="middle"></div>
					<div class="right"></div>
				</div>
			</a>
		</article>


	</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"
		integrity="sha512-RNLkV3d+aLtfcpEyFG8jRbnWHxUqVZozacROI4J2F1sTaDqo1dPQYs01OMi1t1w9Y2FdbSCDSQ2ZVdAC8bzgAg=="
		crossorigin="anonymous">
		
	</script>
	<script src="/reservation/js/common.js">
		
	</script>
	<script src="/reservation/js/myreservation.js">
		
	</script>
</body>

</html>