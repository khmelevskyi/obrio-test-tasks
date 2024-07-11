# Test tasks for OBRIO Nebula

## How to setup and run

1. Create .env file with command below and put your API token inside
```bash
cp .env.example .env
```

2. Setup the virtual environment, download required libraries
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

3. Run the task2
```bash
python -m task2