<template>
	<div class="">
		<div class="no-gutters row">
			<div class="headerContainer d-flex align-items-start primaryBackgroundColor primaryTextColor mx-auto col-12">
				<div class="headerImageContainer primaryBackgroundColor">
					<img src="../assets/nashville-skyline.png">
				</div>
				<button class="btn btn-secondary textHeader ml-auto col-3" type="button">Parcel</button>
				<div class="ml-auto col-8">
					<div class="headerDropdownContainer dropdown primaryTextColor">
						<button class="headerDropdown btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Everything
							<i class="primaryTextColor fa fa-caret-down float-right" aria-hidden="false"></i>
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							<a class="dropdown-item" href="#">Commercial</a>
							<a class="dropdown-item" href="#">Educational</a>
							<a class="dropdown-item" href="#">Residential</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="#"><i class="fa fa-cloud-download" aria-hidden="false"></i>Download PDF</a>
						</div>
					</div>
				</div>
			</div>
<!-- 			<div class="subheaderContainer d-flex align-items-start primaryBackgroundColor mx-auto col-12">
				<img src="../assets/nashville-skyline.png">
			</div> -->
		</div>
	</div>
</template>

<script>

</script>

<style scoped>
.primaryBackgroundColor {
	background-color: #1B355D;
}

.primaryTextColor {
	color: #FFF;
}

.secondaryTextColor {
	color: #4A4A4A;
}

.headerContainer {
	height: 10vh;
	min-height: 4rem;
}

.headerImageContainer {
	position: fixed;
	margin-top: 3.8rem;
}

.headerImageContainer {
	margin-top: 3.8rem;
	z-index: -1;
}

.headerContainer img {
    height: 6rem;
    margin-bottom: -0.5rem;
	opacity: 0.5;
	z-index: -1;
/*	height: 5rem;
	background: #1B355D url("../assets/nashville-skyline.png") no-repeat;
	background-size: contain;*/
}

.textHeader {
    text-align: left;
    font-size: x-large;
    height: 10vh;
    min-height: 4rem;
    max-width: 6.2rem;
    background-color: rgba(255, 255, 255, 0);
    border: none;
}

.btn-secondary.focus, .btn-secondary:focus {
	box-shadow: none;
}

.headerDropdownContainer {
	float: right;
}

.headerDropdown {
	min-width: 164px;
	height: 10vh;
	min-height: 4rem;
    margin-right: 0rem;
    padding: .25rem 1.5rem;
    text-align: left;
    border: none;
    border-radius: initial;
	background-color: rgba(255, 255, 255, 0.19);
}

	.headerDropdown ~ .dropdown-menu {
		background-color: #435572;
		color: #5C6C84;
	}

	.headerDropdown ~ .dropdown-menu a {
		padding: 3vh 1.5rem;
		font-size: 1rem;
		color: #FFF;
	}

		.headerDropdown ~ .dropdown-menu a:hover {
			background-color: #2F4263;
		}

	.headerDropdown ~ .show {
		top: -2px;
		left: 0px;
		width: 164px;
		margin: 0;
		padding-top: 0;
		border-radius: 0;
		border: none;
	}

	.headerDropdown ~ .fa-caret-down {
		text-align: right;
	}

.dropdown-toggle::after {
	border: none;
}

.show >.headerDropdown.dropdown-toggle {
	background-color: #435572;
}

.fa-cloud-download {
	margin-right: 0.5rem;
	color: #FFF;
}

@media (min-width: 575px) {
	.headerDropdown {
		min-width: 18rem;
	}

	.headerImageContainer {
		margin-top: 3rem;
	}

	.headerContainer img {
		height: initial;
	}

	.headerDropdown ~ .show {
		top: -2px;
		left: 0px;
		min-width: 18rem;
		margin: 0;
		border-radius: 0;
		border: none;
	}
}

@media (min-width: 767px) {
	.textHeader {
	    font-size: 3vw;
	}
}

@media (min-width: 1199px) {
	.headerContainer {
	    height: 5rem;
	    max-width: 1440px;
	}

	.subheaderContainer {
	    max-width: 1440px;
	}

	.textHeader {
	    height: 5rem;
	    text-align: left;
	    font-size: 2.2rem;
	}

	.headerDropdown {
	    width: 24rem;
		height: 5rem;
	}

	.headerDropdown ~ .show {
		min-width: 24rem;
	}
}

@media (min-width: 1440px) {
	.textHeader {
	    padding-left: 4.5rem;
	}

	.headerDropdown {
	    margin-right: 7rem;
	}
}

</style>