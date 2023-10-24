local currency_builder do
    currency_builder = {
        __current = nil,
        __target = nil
    }

    currency_builder.__index = currency_builder
end

function currency_builder.new(current, target)
    local __currency_builder_mt do
        __currency_builder_mt = setmetatable({}, currency_builder)

        do
            __currency_builder_mt.__current = string.upper(current)
            __currency_builder_mt.__target = string.upper(target)
        end
    end

    return __currency_builder_mt
end

function currency_builder:set_current(current)
    self.__current = current
end

function currency_builder:get_current()
    return self.__current
end

function currency_builder:set_target(target)
    self.__target = target
end

function currency_builder:get_target()
    return self.__target
end

function currency_builder:convert_to_string(flip)
    return string.format("%s/%s", self.__current, self.__target)
end

return currency_builder