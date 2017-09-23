<template>
	<div class="">
		<div class="no-gutters row">
			<div class="headerContainer d-flex align-items-start primaryBackgroundColor primaryTextColor mx-auto col-12">
				<h1 class="textHeader ml-auto col-3">Parcel</h1>
				<div class="ml-auto col-8">
					<div class="dropdown primaryTextColor">
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
			<div class="subheaderContainer d-flex align-items-start primaryBackgroundColor mx-auto col-12">
				<img src="../assets/nashville-skyline.png">
			</div>
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
	height: 7vh;
}

.subheaderContainer {
/*	height: 5rem;
	background: #1B355D url("../assets/nashville-skyline.png") no-repeat;
	background-size: contain;*/
}

.textHeader {
	margin-top: 0.5rem;
	text-align: left;
	font-size: 1.2rem;
}

.headerDropdown {
	min-width: 164px;
	height: 7vh;
    margin-right: 0rem;
    padding: .25rem 1.5rem;
    text-align: left;
    border: none;
    border-radius: initial;
	background-color: #5C6C84;
}

	.headerDropdown ~ .dropdown-menu {
		background-color: #5C6C84;
		color: #5C6C84;
	}

	.headerDropdown ~ .dropdown-menu a {
		font-size: 0.9rem;
		color: #FFF;
	}

		.headerDropdown ~ .dropdown-menu a:hover {
			background-color: #485D7D;
		}

	.headerDropdown ~ .show {
		top: -2px;
		left: 0px;
		width: 164px;
		margin: 0;
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
	background-color: #5C6C84;
}

.fa-cloud-download {
	margin-right: 0.5rem;
	color: #FFF;
}
</style>