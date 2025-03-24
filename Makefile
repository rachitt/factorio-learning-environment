.PHONY: sqlite3 openplay test test-single clean help docker-build docker-run docker-stop docker-status

help:
	@echo "Available commands:"
	@echo "  make test              - Run all tests"
	@echo "  make test-single TEST=test_file.py::test_name - Run a single test"
	@echo "  make sqlite3           - Initialize SQLite database"
	@echo "  make openplay          - Run open play simulation"
	@echo "  make docker-build      - Build the Factorio Docker image"
	@echo "  make docker-run        - Run the Factorio server in Docker"
	@echo "  make docker-stop       - Stop the running Docker container"
	@echo "  make docker-status     - Check status of Docker container"
	@echo "  make clean             - Clean temporary files"

sqlite3:
	./scripts/init_sqlite3.sh

openplay:
	uv run python eval/open/independent_runs/run.py --run_config=eval/open/independent_runs/run_config_example_open_play.json

test:
	uv run python -m pytest env/tests

test-single:
	uv run python -m pytest env/tests/$(TEST)

docker-build:
	cd cluster/docker && docker build -t factorio .

docker-run:
	@echo "Starting Factorio server..."
	@if [ ! -z "$$(docker ps -q -f name=factorio)" ]; then \
		echo "Factorio server is already running"; \
	else \
		echo "Creating new Factorio container..."; \
		cd cluster/local && \
		docker compose -f docker-compose-1.yml up -d; \
	fi
	@echo "Factorio server running on TCP port 27000"

docker-stop:
	@echo "Stopping Factorio server..."
	@if [ ! -z "$$(docker ps -q -f name=factorio)" ]; then \
		docker stop "$$(docker ps -q -f name=factorio)"; \
		docker rm "$$(docker ps -q -f name=factorio)"; \
		echo "Factorio server stopped and container removed"; \
	else \
		echo "No Factorio server running"; \
		docker rm -f "$$(docker ps -q -f name=factorio)" 2>/dev/null || true; \
		echo "Removed any stale containers"; \
	fi

docker-status:
	@if [ ! -z "$$(docker ps -q -f name=factorio)" ]; then \
		echo "Factorio server is running"; \
		docker logs --tail 10 "$$(docker ps -q -f name=factorio)"; \
	else \
		echo "Factorio server is not running"; \
	fi

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name "*.egg" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
