import os
import time
from datetime import datetime, timedelta

import requests
import pandas as pd

# Define the API endpoint and your access key
api_url = "https://api.freecurrencyapi.com/v1/historical"
api_key = os.getenv("API_key")

def get_the_data_from_api() -> pd.DataFrame:
    # Defining the date range
    end_date = datetime.now() - timedelta(days=1)
    start_date = end_date - timedelta(days=37)

    # List to hold the daily data
    historical_data = []

    # Iterating over each date
    for current_date in pd.date_range(start=start_date, end=end_date):
        date_str = current_date.strftime('%Y-%m-%d')
        params = {
            "apikey": api_key,
            "currencies": "EUR,USD",
            "base_currency": "EUR",
            "date": date_str
        }

        # Making the API request
        response = requests.get(api_url, params=params)
        while response.status_code == 429:
            # Here avoiding quota limit
            print(response.json())
            time.sleep(10)
            response = requests.get(api_url, params=params)
        data = response.json()
        print(data)

        # Extracting the historical data for the current date
        rate = data['data'][date_str]['USD']
        historical_data.append({
            'date': date_str,
            'EUR/USD': rate
        })

    # Creating a DataFrame
    df = pd.DataFrame(historical_data)
    df['date'] = pd.to_datetime(df['date'])
    df.set_index('date', inplace=True)

    print(df.head())

    # Saving to CSV
    df.to_csv("task2/currency_rate_data.csv")

    return df

if __name__ == "__main__":
    get_the_data_from_api()
