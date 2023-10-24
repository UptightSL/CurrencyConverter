local currency_builder = require("src.currency_builder")

local exchange_rates = {
    rates = {}
}

function exchange_rates.add_rate(current_rate, target_rate, current_value)
    local rate = currency_builder.new(current_rate, target_rate)
    
    local rate_string, rate_function do
        rate_string = rate:convert_to_string()

        function rate_function(value)
            return (value * current_value)
        end
    end

    do
        exchange_rates.rates[rate_string] = rate_function
    end
end

function exchange_rates.get_rate(current, target)
    local rate = currency_builder.new(current, target)

    local return_rate do
        local rate = rate:convert_to_string()
        
        if (exchange_rates.rates[rate]) then
            return_rate = exchange_rates.rates[rate]
        end
    end

    return return_rate
end

do
    do
        exchange_rates.add_rate("USD", "USD", 1.00)
        exchange_rates.add_rate("USD", "EUR", 0.94)
        exchange_rates.add_rate("USD", "GBP", 0.82)
        exchange_rates.add_rate("USD", "JPY", 149.87)
        exchange_rates.add_rate("USD", "CAD", 1.37)
    end

    do
        exchange_rates.add_rate("EUR", "EUR", 1.00)
        exchange_rates.add_rate("EUR", "USD", 1.06)
        exchange_rates.add_rate("EUR", "GBP", 0.87)
        exchange_rates.add_rate("EUR", "JPY", 158.75)
        exchange_rates.add_rate("EUR", "CAD", 1.45)
    end

    do
        exchange_rates.add_rate("GBP", "GBP", 1.00)
        exchange_rates.add_rate("GBP", "USD", 1.22)
        exchange_rates.add_rate("GBP", "EUR", 1.15)
        exchange_rates.add_rate("GBP", "JPY", 182.32)
        exchange_rates.add_rate("GBP", "CAD", 1.67)
    end

    do
        exchange_rates.add_rate("JPY", "JPY", 1.00)
        exchange_rates.add_rate("JPY", "USD", 0.0067)
        exchange_rates.add_rate("JPY", "EUR", 0.0063)
        exchange_rates.add_rate("JPY", "GBP", 0.0055)
        exchange_rates.add_rate("JPY", "CAD", "0.0092")
    end

    do
        exchange_rates.add_rate("CAD", "CAD", 1.00)
        exchange_rates.add_rate("CAD", "USD", 0.73)
        exchange_rates.add_rate("CAD", "EUR", 0.69)
        exchange_rates.add_rate("CAD", "GBP", 0.60)
        exchange_rates.add_rate("CAD", "JPY", 109.16)
    end
end

return exchange_rates