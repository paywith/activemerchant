build:
	docker-compose build

bash:
	docker-compose run --rm gem bash

brakeman:
	docker-compose run --rm gem brakeman --no-pager --path . --force

release:
	docker run -v $$PWD:/var/gem --rm  -w /var/gem --entrypoint ./scripts/release paywith-activemerchant-gem $$GITHUB_TOKEN
