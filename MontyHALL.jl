using Plots



good_dict = Dict("door 1" => "goat", "door 2" => "goat", "door 3" => "supercar")


function MontyHall(initial_dict::Dict, change::Bool)

    updated_dict = copy(initial_dict)

    my_choice = rand(keys(updated_dict))
    value_my_choice = updated_dict[my_choice]
    updated_dict = delete!(updated_dict, my_choice)

    for key in keys(updated_dict)
        if updated_dict[key] == "goat"
            updated_dict = delete!(updated_dict, key)
            break
        end
    end
    
    my_choice_after_change, prize_after_choice = WouldIChange(change, my_choice, value_my_choice, updated_dict)

    return prize_after_choice
    
end


#=function WouldIChange(change :: Bool, dictonary_updated :: Dict)

    if change == true
        boss_key = first(keys(dictonary_updated))
        boss_value = dictonary_updated[boss_key]

        ### exchange
        dummy_key = my_choice
        dumm_val = value_my_choice

        my_choice = boss_key
        value_my_choice = boss_value

        boss_key = dummy_key
        boss_value = dumm_val
    end
    return my_choice, value_my_choice
end
=#

function WouldIChange(change::Bool, my_choice::String, value_my_choice::String, dict_updated::Dict)
    if change == true && !isempty(dict_updated)
        boss_key = first(keys(dict_updated))  
        boss_value = dict_updated[boss_key]

        return boss_key, boss_value
    else
        return my_choice, value_my_choice
    end
end


function RunWithExchange(N::Int)
    my_prizes = []
    for _ in 1:N
        final_win = MontyHall(good_dict, true)
        push!(my_prizes, string(final_win))
    end
    count_supercar = 0
    for x in my_prizes
        if x == "supercar"
            count_supercar += 1
        end
    end
    return count_supercar
end


function RunWithOutExchange(N::Int)
    my_prizes = []
    for _ in 1:N
        final_win = MontyHall(good_dict, false)
        push!(my_prizes, string(final_win))
    end
    count_supercar = 0
    for x in my_prizes
        if x == "supercar"
            count_supercar += 1
        end
    end
    return count_supercar
end


num_iterations = collect(0:5:50)
supercars_exchange, supercars_no_exchange = [], []

for i in 1:length(num_iterations)
    super_car_w_exchange = RunWithExchange(num_iterations[i])
    push!(supercars_exchange, super_car_w_exchange)
    super_car_wout_exchange = RunWithOutExchange(num_iterations[i])
    push!(supercars_no_exchange, super_car_wout_exchange)
end


p = plot(num_iterations,
supercars_exchange,
xlabel="Number of Iterations",
ylabel="Supercars Won",
title="Monty Hall Cumulative Simulation Results",
labels="With Exchange",
marker=:circle)
plot!(num_iterations,
supercars_no_exchange,
labels="Without Exchange",
marker=:square)

savefig(p, "/Users/francescoaldoventurelli/Downloads/MontyHall.png")