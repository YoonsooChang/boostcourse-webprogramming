<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TO-DO LIST</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/main.css">
</head>
<body>
	<section id="container-main">
		<header>
			<button class="btn-register">새로운 TODO등록</button>
		</header>
		<article id="title">나의 해야할 일들</article>
		<section id="container-items">
			<section id="todos" class="card-col">
				<article class="card-col-header">TODO</article>
				<c:forEach items="${todos}" var="item">
					<article id="todo-${item.id}" class="card-item">
						<p class="card-title">${item.title}</p>
						<span class="card-detail">등록날짜: ${item.regDate}
							${item.name} 우선순위 ${item.sequence}</span>
						<button class="btn-update">→</button>
					</article>
				</c:forEach>
			</section>

			<section id="doings" class="card-col">
				<article class="card-col-header">DOING</article>
				<c:forEach items="${doings}" var="item">
					<article id="doing-${item.id}" class="card-item">
						<p class="card-title">${item.title}</p>
						<span class="card-detail">등록날짜: ${item.regDate}
							${item.name} 우선순위 ${item.sequence}</span>
						<button class="btn-update">→</button>
					</article>
				</c:forEach>
			</section>

			<section id="dones" class="card-col">
				<article class="card-col-header">DONE</article>
				<c:forEach items="${dones}" var="item">
					<article id="done-${item.id}" class="card-item">
						<p class="card-title">${item.title}</p>
						<span class="card-detail">등록날짜: ${item.regDate}
							${item.name} 우선순위 ${item.sequence}</span>
						<button class="btn-update">→</button>
					</article>
				</c:forEach>
			</section>
		</section>
	</section>
</body>
<script src="js/main.js">
	
</script>
</html>