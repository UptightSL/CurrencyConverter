local exchange_rates, currency_builder, ffi do
    exchange_rates = require("src.exchange_rates")
    currency_builder = require("src.currency_builder")
    ffi = require("ffi")
end

local function clear_console()
    if (ffi.os) == "Linux" then
        os.execute("clear")
    else
        os.execute("cls")
    end
end

local function get_current()
    clear_console()

    io.write("Select your current currency: \n\n")
    
    do
        io.write("1. USD\n")
        io.write("2. EUR\n")
        io.write("3. GBP\n")
        io.write("4. JPY\n")
        io.write("5. CAD\n")
    end

    io.write("\n> ")

    return io.read()
end

local function get_target()
    clear_console()

    io.write("Select your target currency: \n\n")

    do
        io.write("1. USD\n")
        io.write("2. EUR\n")
        io.write("3. GBP\n")
        io.write("4. JPY\n")
        io.write("5. CAD\n")
    end

    io.write("\n> ")

    return io.read()
end

local function get_value()
    clear_console()
    
    io.write("Enter the amount of money: (Must be a number!)\n\n")
    io.write("> ")

    return io.read()
end

do
    local current do
        current = get_current()
    end

    local target do
        target = get_target()
    end

    local value do
        value = get_value()
    end

    local rate_string = currency_builder.new(current, target)

    do
        clear_console()

        local rate = exchange_rates.get_rate(rate_string:get_current(), rate_string:get_target())

        if (type(rate) == "function") then
            io.write(rate_string:convert_to_string() .. " -> " .. string.format("%.3f", rate(value)) .. "\n\n")
        end
    end
end