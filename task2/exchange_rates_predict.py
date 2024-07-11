import pandas as pd
import statsmodels.api as sm
import matplotlib.pyplot as plt


# Використовуємо ARIMA для прогнозування часових рядів через
# його можливість управляти трендами та сезонними змінами даних.
# Він не потребує складної інженерії ознак та має чіткі параметри,
# що допомагають зрозуміти, як саме модель прогнозує майбутні значення на основі минулих даних.

def predict_and_plot(df: pd.DataFrame) -> None:
    validation_days = 7

    # Split the data into training and validation sets
    train = df[:-validation_days]

    # Fit the ARIMA model on the training data
    model = sm.tsa.ARIMA(train, order=(7, 0, 1))
    model_fit = model.fit()

    # Forecast the next 7 days
    forecast = model_fit.forecast(steps=validation_days)
    forecast_df = pd.DataFrame(forecast)

    # Plot the actual and forecast data
    plt.figure(figsize=(12, 6))
    plt.plot(df, label='Actual')
    plt.plot(forecast_df, label='Forecast', linestyle='--')
    plt.title('EUR/USD Exchange Rate')
    plt.xlabel('Date')
    plt.ylabel('Exchange Rate')
    plt.legend()
    plt.savefig("task2/actual_vs_predicted.png")
    plt.show()


if __name__ == "__main__":
    df = pd.read_csv("task2/currency_rate_data.csv", parse_dates=['date'], index_col='date')
    predict_and_plot(df)
