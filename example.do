version 13 // currently needs 13 or 14

* Install requirements
	cap ado uninstall moresyntax
	net install moresyntax, from("C:/git/moresyntax/src")

	cap ado uninstall ftools
	net install ftools, from("C:/git/ftools/src")
	ftools, compile

* Instal reghdfe
	cap ado uninstall reghdfe
	net install reghdfe , from("https://github.com/sergiocorreia/reghdfe/raw/version-4/src/")
	reghdfe, compile

* Install demo
	cap ado uninstall ivreghdfe
	net install ivreghdfe, from("https://github.com/sergiocorreia/ivreg2_demo/raw/master/")
	//net install ivreghdfe, from(c:\git\ivreg2_demo)

* Setup
	clear all
	discard
	pr drop _all
	cls
	sysuse auto
	replace turn = . in 1 // ensure we detect MVs in absorb()

* Sanity checks
	ivreg2 price weight // ensure ivreg2 works
	ivreg2 price weight i.turn , partial(i.turn) small // equivalent to the HDFE version
	ivreghdfe price weight // ensure ivreghdfe works
	ivreghdfe // ensure replay() works

* Test absorb()
	ivreghdfe price weight, absorb(turn)
	ivreghdfe // ensure replay() works

* Benchmark
	reghdfe price weight, a(turn) keepsingletons


* Advanced: TWFE
	ivreghdfe price weight, absorb(turn trunk)
	reghdfe price weight, absorb(turn trunk) keepsing

* Cluster
	ivreghdfe price weight, absorb(turn) cluster(turn)
	reghdfe price weight, absorb(turn) vce(cluster turn) keepsing

* TWC and TWFE
	ivreghdfe price weight, absorb(turn foreign) cluster(turn trunk)
	reghdfe price weight, absorb(turn foreign) cluster(turn trunk) keepsing

exit
