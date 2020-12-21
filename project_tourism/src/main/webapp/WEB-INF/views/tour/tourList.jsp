<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관광 정보</title>
<script src="http://code.jquery.com/jquery-3.5.1.min.js">
</script>
<script>
	function list(page) {
		location.href="tourList?pageNo="+page+"&keyword=${keyword}"+"&areaCode=${areaCode}"+"&sigunguCode=${sigunguCode}"+"&contentTypeId=${contentTypeId}";
	}
	
	function getSigunguList(code,initFlag){
		console.log(code)
		var param = {'code' : code}
		console.log(param)
		var sigunarea = JSON.stringify(param)
		console.log(sigunarea)	
	    $.ajax({
	    	url : "../search/areaSearch.do",
	        type: "post",
	        dataType: "json",
	        contentType: "application/json; charset=utf-8;",
	        data : sigunarea,
	        success:function(data){
	        	$("select[name=sigunguCode]").empty();	        	
	        	$("select[name=sigunguCode]").append("<option value=''>시군구 선택</option>");
	        	
	        	for(var  i = 0;  i < data.list.length; i ++){	        		
	        		$("select[name=sigunguCode]").append("<option value="+data.list[i].code+">"+ data.list[i].name +"</option>");
	        	}
	        	
	        	if( initFlag == "N") {
	        		// 시군구 selected	        	
		    		$("select[name=sigunguCode] > option").each(function(){
		    			if( $(this).val() == ""){
		    				$(this).attr("selected","selected");
		    			}	    			
		    		});
	        	}
	        },
			error:function(args){
				alert('error' + args);
			}
	    });
	}
	
	function searchTour() {
		fo.submit()
	}
</script>
</head>
<body>
	<c:import url="../default/header.jsp"/>
	<div>
		<div>
			<h2>지역 관광 정보 검색</h2>
		</div>
			<form id="fo" action="tourList" method="post">
			<table class="bbsSearch" style="border:0px;">
			<colgroup>
				<col style="width:95px;">
				<col width="width:861px !important;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">관광타입</th>
					<td>
						<select title="타입선택" name="contentTypeId">
							<option value="" selected="selected">타입선택</option>
							<option value="12" <c:out value="${contentTypeId == '12'?'selected':''}"/>>관광지</option>
							<option value="14" <c:out value="${contentTypeId == '14'?'selected':''}"/>>문화시설</option>
							<option value="15" <c:out value="${contentTypeId == '15'?'selected':''}"/>>행사/공연/축제</option>
							<option value="25" <c:out value="${contentTypeId == '25'?'selected':''}"/>>여행코스</option>
							<option value="28" <c:out value="${contentTypeId == '28'?'selected':''}"/>>레포츠</option>
							<option value="32" <c:out value="${contentTypeId == '32'?'selected':''}"/>>숙박</option>
							<option value="38" <c:out value="${contentTypeId == '38'?'selected':''}"/>>쇼핑</option>
							<option value="39" <c:out value="${contentTypeId == '39'?'selected':''}"/>>음식점</option>	
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row">지역</th>
					<td>
						<select title="지역선택" name="areaCode" onchange="getSigunguList(this.value)">
							<option value="" selected="selected">지역선택</option>
							<option value="1"<c:out value="${areaCode == '1'?'selected':''}"/>>서울</option>
							<option value="2"<c:out value="${areaCode == '2'?'selected':''}"/>>인천</option>
							<option value="3"<c:out value="${areaCode == '3'?'selected':''}"/>>대전</option>
							<option value="4"<c:out value="${areaCode == '4'?'selected':''}"/>>대구</option>
							<option value="5"<c:out value="${areaCode == '5'?'selected':''}"/>>광주</option>
							<option value="6"<c:out value="${areaCode == '6'?'selected':''}"/>>부산</option>
							<option value="7"<c:out value="${areaCode == '7'?'selected':''}"/>>울산</option>
							<option value="8"<c:out value="${areaCode == '8'?'selected':''}"/>>세종특별자치시</option>
							<option value="31"<c:out value="${areaCode == '31'?'selected':''}"/>>경기도</option>
							<option value="32"<c:out value="${areaCode == '32'?'selected':''}"/>>강원도</option>
							<option value="33"<c:out value="${areaCode == '33'?'selected':''}"/>>충청북도</option>
							<option value="34"<c:out value="${areaCode == '34'?'selected':''}"/>>충청남도</option>
							<option value="35"<c:out value="${areaCode == '35'?'selected':''}"/>>경상북도</option>
							<option value="36"<c:out value="${areaCode == '36'?'selected':''}"/>>경상남도</option>
							<option value="37"<c:out value="${areaCode == '37'?'selected':''}"/>>전라북도</option>
							<option value="38"<c:out value="${areaCode == '38'?'selected':''}"/>>전라남도</option>
							<option value="39"<c:out value="${areaCode == '39'?'selected':''}"/>>제주도</option>		
						</select>
						<select name="sigunguCode" title="시군구선택">
							<option value="" selected="selected">시군구선택</option>
						</select>	
					</td>
				</tr>
				<tr>
					<th> 검색 </th>
					<td>
						<input type="text" name="keyword" value="${keyword }"> 
						<button type="button" onclick="searchTour()">검색</button>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
	</div>
	
			<c:choose>
			<c:when test="${map.list.size() != 0}">
				<c:forEach var="list" items="${map.list }">
				<hr>
					<a href='tourdetail?contentid=${list.contentid }&contenttypeid=${list.contenttypeid }'>
						<div>
							<div style="width: 25%; align-content: left;">
								<img style="height: 400px; width: 400px;"onerror="this.src='/resources/images/noimage.png'" src="${list.firstimage }">
							</div>
							<h4>${list.title }</h4>
							<p>${list.addr1 }</p>
							<p>${list.tel }</p>
							작성일자 : ${list.createdtime }<br>
							수정일자 : ${list.modifiedtime }
						</div>
					</a>
					<hr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				검색 결과가 없습니다.
			</c:otherwise>
			</c:choose>
			
					<!-- 처음페이지로 이동 : 현재 페이지가 1보다 크면 [처음] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curPage > 1 }">
						<a href="javascript:list('1')">[처음]</a>
					</c:if>
					
					<!-- 이전페이지 블록으로 이동 : 현재 페이지 블록이 1보다 크면 [이전] 링크를 화면에 출력-->
					<c:if test="${map.pagination.curBlock > 1 }">
						<a href="javascript:list('${map.pagination.prevPage }')">[이전]</a>
					</c:if>
					<!-- 하나의 블럭 시작페이지부터 끝페이지까지 반복문 실행 -->
					<c:forEach var="num" begin="${map.pagination.blockBegin }" end="${map.pagination.blockEnd }">
						<!-- 현재 페이지면 하이퍼링크 제거 -->
						<c:choose>
							<c:when test="${num == map.pagination.curPage }">
								<span style="color:red;">${num }</span>&nbsp;
							</c:when>
							<c:otherwise>
								<a href="javascript:list('${num }')">${num }</a>&nbsp;
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<!-- 다음페이지 블록으로 이동 : 현재 페이지 블록이 전체 페이지 블록보다 작거나 같으면 [다음] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curBlock <= map.pagination.totBlock}">
						<a href="javascript:list('${map.pagination.nextPage }')">[다음]</a>
					</c:if>
					
					<!-- 끝 페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝] 링크를 화면에 출력 -->
					<c:if test="${map.pagination.curPage <= map.pagination.totPage }">
						<a href="javascript:list('${map.pagination.totPage }')">[끝]</a>
					</c:if>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					총  <span style="color: blue;">${map.count }</span>개의 게시물이 있습니다.
				
	<c:import url="../default/footer.jsp"/>
</body>
</html>