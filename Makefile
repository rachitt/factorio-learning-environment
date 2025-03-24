sqlite3:
	./scripts/init_sqlite3.sh

openplay:
	uv run python eval/open/independent_runs/run.py --run_config=eval/open/independent_runs/run_config_example_open_play.json
