let productImageContainer;
let productImageCount;

let imagePos = 1;
let imageStart, imageEnd;
let currentImageNumNode;

const startLoad = () => {
	reqHandler.getRequest();
};

const appendDetails = (data) => {
	const { averageScore,
		comments,
		displayInfo: {
			placeLot,
			placeName,
			placeStreet,
			telephone,
			productDescription,
			productContent,
		},
		displayInfoImage: {
			saveFileName,
		},
		productImages,
		productPrices
	} = JSON.parse(data);


	// <1> 이미지 슬라이드
	productImageContainer = document.getElementById("product-image-slide");
	productImageCount = productImages.length;

	const bindProductImage = Handlebars.compile(document.getElementById("productImagesItem").innerText);

	productImages.forEach(image => {
		image.productTitle = productDescription;
		productImageContainer.innerHTML += bindProductImage(image);
	});

	currentImageNumNode = document.getElementById("current-figure");
	currentImageNumNode.innerHTML = 1;

	document.getElementById("total-figure").innerHTML = productImageCount;

	setUpImageSlide();

	//<2> 펼쳐보기 
	const contentOpener = document.querySelector("._open ");
	const contentCloser = document.querySelector("._close");
	const contentSection = document.getElementById("product-content-section");

	contentOpener.onclick = (e) => {
		e.preventDefault();

		contentOpener.style.display = "none";
		contentCloser.style.display = "block";
		contentSection.classList.remove("close3");
	}

	contentCloser.onclick = (e) => {
		e.preventDefault();

		contentCloser.style.display = "none";
		contentOpener.style.display = "block";
		contentSection.classList.add("close3");
	}

	//<3> 한줄평
	document.getElementById("average-score").innerHTML = parseFloat(averageScore).toFixed(1);
	document.getElementById("star-score").style.width = parseFloat(averageScore) / 5.0 * 100 + "%";
	document.getElementById("comment-counts").innerHTML = comments.length + "건";

	document.querySelectorAll(".product_content").forEach(item => item.innerText = productContent);
	const reviewMoreBtn = document.getElementById("btn-review-more");
	reviewMoreBtn.setAttribute("href", `review?id=${urlGetParams.get("id")}`);

	const shortReviewContainer = document.getElementById("review-short");

	Handlebars.registerHelper("formatDate", function(date) {
		return `${date.year}.${date.monthValue}.${date.dayOfMonth} 방문`;
	});

	const bindComment = Handlebars.compile(document.getElementById("commentsItem").innerText);
	comments.forEach((comment) => shortReviewContainer.innerHTML += bindComment(comment));


	//<4> 오시는길
	const detailTab = document.getElementById("to-detail");
	const locationTab = document.getElementById("to-location");

	detailTab.onclick = (e) => {
		e.preventDefault();

		detailTab.classList.add("active");
		locationTab.classList.remove("active");
		document.getElementById("tab-detail").classList.remove("hide");
		document.getElementById("tab-location").classList.add("hide");
	}

	locationTab.onclick = (e) => {
		e.preventDefault();

		locationTab.classList.add("active");
		detailTab.classList.remove("active");
		document.getElementById("tab-detail").classList.add("hide");
		document.getElementById("tab-location").classList.remove("hide");
	}

	document.getElementById("map-image").setAttribute("src", saveFileName);
	document.getElementById("store-street").innerHTML = placeStreet;
	document.getElementById("store-lot").innerHTML = placeLot;
	document.getElementById("store-name").innerHTML = placeName;
	document.getElementById("store-telephone").innerHTML = telephone;
	document.getElementById("store-telephone").setAttribute("href", `tel:${telephone}`);

}

const setUpImageSlide = () => {
	const prevImageLink = document.getElementById("product-image-prev");
	const nextImageLink = document.getElementById("product-image-nxt");

	if (productImageCount === 1) {
		prevImageLink.style.display = "none";
		nextImageLink.style.display = "none";
		return;
	}

	const firstChildClone = productImageContainer.firstElementChild.cloneNode(true);
	const lastChildClone = productImageContainer.lastElementChild.cloneNode(true);

	productImageContainer.appendChild(firstChildClone);
	productImageContainer.insertBefore(lastChildClone, productImageContainer.firstElementChild);

	imageStart = 1;
	imageEnd = productImageCount;

	productImageContainer.style.left = "-100%";

	prevImageLink.onclick = slideToLeft;
	nextImageLink.onclick = slideToRight;

}

const moveForASecond = () => {
	productImageContainer.style.transition = "left 1s ease-in";
	productImageContainer.style.left = -imagePos * 100 + "%";
}

const blinkTo = (destination) => {
	productImageContainer.style.transition = "none";
	imagePos = destination;
	productImageContainer.style.left = -destination * 100 + "%";
}

const slideToLeft = (e) => {
	e.preventDefault();

	currentImageNumNode.innerHTML = (imagePos === 1 ? imageEnd : imagePos - 1);
	imagePos--;
	moveForASecond();

	if (imagePos === imageStart - 1) {
		setTimeout(() => blinkTo(imageEnd), 1000);
	}
}

const slideToRight = (e) => {
	e.preventDefault();

	currentImageNumNode.innerHTML = (imagePos === imageEnd ? imageStart : imagePos + 1);
	imagePos++;
	moveForASecond();

	if (imagePos === imageEnd + 1) {
		setTimeout(() => blinkTo(imageStart), 1000);
	}
}

const urlGetParams = new URL(window.location.href).searchParams;
const reqHandler = new RequestHandler(`api/display/${urlGetParams.get("id")}`, appendDetails, () => console.log('error'), () => true)

document.addEventListener("DOMContentLoaded", startLoad);