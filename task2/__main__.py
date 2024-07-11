from task2.exchange_rates_fetch import get_the_data_from_api
from task2.exchange_rates_predict import predict_and_plot

if __name__ == "__main__":
    df = get_the_data_from_api()
    predict_and_plot(df)
