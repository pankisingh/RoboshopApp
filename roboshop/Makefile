help:     		## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
frontend: 		## Installing Frontend Component
	@bash frontend.sh
catalogue: 		## Installing Catalogue Component
	@bash catalogue.sh
cart: 			## Installing Cart Component
	@bash cart.sh
shipping: 		## Installing Shipping Component
	@bash shipping.sh
user: 			## Installing User Component
	@bash user.sh
payment: 		## Installing Payment Component
	@bash payment.sh
redis: 			## Installing Redis Component
	@bash redis.sh
mysql: 			## Installing Mysql Component
	@bash mysql.sh
rabbitmq: 		## Installing Rabbitmq Component
	@bash rabbitmq.sh
mongodb: 		## Installing Mongodb Component
	@bash mongodb.sh
database: mongodb redis mysql rabbitmq   ## Install All Database
	