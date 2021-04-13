<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%response.setContentType("text/html; charset=UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>∴kakakoMap∵</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    
	table{
		width: 1000px;
	}
	tr > th{
		text-align: left;
	}
</style>
</head>
<body>
		<p><em>지도를 클릭해주세요!</em></p>
						약속장소	<br/>
						<div id="makerSpace" >
							<input type="" name="postLatitude" value=""/>
						</div>
					
						<input type="hidden" id="MapAddress" name="MapAddress" value="" /> 
						<div class="map_wrap">
						    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
						    <div id="menu_wrap" class="bg_white">
					 	   </div>
							    <div class="hAddr">
						        <span class="title">지도중심기준 행정동 주소정보</span>
						        <span id="centerAddr"></span>
						    </div>
						</div>
					
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=86abc3ded66eb29aaab5915248a36ab4&libraries=services"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							    mapOption = {
							        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
							        level: 1 // 지도의 확대 레벨
							    };  
							
							// 지도를 생성합니다    
							var map = new kakao.maps.Map(mapContainer, mapOption); 
							
							// 주소-좌표 변환 객체를 생성합니다
							var geocoder = new kakao.maps.services.Geocoder();
							
							var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
							    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
							
							    
							// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
							searchAddrFromCoords(map.getCenter(), displayCenterInfo);
							
							// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
							kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
							    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
							        if (status === kakao.maps.services.Status.OK) {
							        	
							            var detailAddr = !!result[0].road_address ? '<div>도로명 : ' + result[0].road_address.address_name + '</div>' : '';
							            detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';
							            
							            var MapAddresss = '<div class="bAddr">' +
							                            '<span class="title">법정동 주소정보</span>' + 
							                            detailAddr + 
							                        '</div>';
							                        
							            $("#MapAddress").val(mouseEvent)
										
							           // var markerSpace = document.getElementById("makerSpace");
							            var test = document.getElementsByName("postLatitude")[0];
							            
							            var afterString = detailAddr.slice(detailAddr.indexOf(">")+1, detailAddr.lastIndexOf("<"));
							           // makerSpace.innerHTML = detailAddr;
							         	test.value = afterString;
							            
							         	
							            
							            // 마커를 클릭한 위치에 표시합니다 
							            marker.setPosition(mouseEvent.latLng);
							            marker.setMap(map);
							            
							            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
							            infowindow.setContent(MapAddress);
							            
							            
							        }   
							        
							    });
							});
							
							// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
							kakao.maps.event.addListener(map, 'idle', function() {
							    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
							});
							
							function searchAddrFromCoords(coords, callback) {
							    // 좌표로 행정동 주소 정보를 요청합니다
							    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
							}
							
							function searchDetailAddrFromCoords(coords, callback) {
							    // 좌표로 법정동 상세 주소 정보를 요청합니다
							    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
							}
							
							// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
							function displayCenterInfo(result, status) {
							    if (status === kakao.maps.services.Status.OK) {
							        var infoDiv = document.getElementById('centerAddr');
							
							        for(var i = 0; i < result.length; i++) {
							            // 행정동의 region_type 값은 'H' 이므로
							            if (result[i].region_type === 'H') {
							                infoDiv.innerHTML = result[i].address_name;
							                break;
							            }
							        }
							    }    
							}
							
						</script>
</body>
</html>