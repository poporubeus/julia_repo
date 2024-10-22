using DataFrames
using CSV
using Statistics
using Plots
using LaTeXStrings


num_files = 4

dir_path = "/Users/francescoaldoventurelli/Desktop/QAOA_transferability/TEST"
url4 = "/data50_qubit_1_layers_opt_test_change_subset_4.csv"
url6 = "/data50_qubit_1_layers_opt_test_change_subset_6.csv"



function Readdata(csv_url)
    df_list = [CSV.read(dir_path * csv_url, DataFrame)]
    return df_list
end

df_list4 = Readdata(url4)
df_list6 = Readdata(url6)
#df_list6 = [CSV.read(dir_path * "/data50_qubit_1_layers_opt_test_change_subset_6.csv", DataFrame)]

for i in 2:num_files
    push!(df_list4, CSV.read(dir_path * "/data50_qubit_$(i)_layers_opt_test_change_subset_4.csv", DataFrame))
    push!(df_list6, CSV.read(dir_path * "/data50_qubit_$(i)_layers_opt_test_change_subset_6.csv", DataFrame))
end

initial_energy_mean = [mean(df_list4[i][:, "Initial energy"]) for i in 1:length(df_list4)]
first_iter_energy_mean = [mean(df_list4[i][:, "First iter energy"]) for i in 1:length(df_list4)]
initial_energy_std = [std(df_list4[i][:, "Initial energy"]) for i in 1:length(df_list4)]
first_iter_energy_std = [std(df_list4[i][:, "First iter energy"]) for i in 1:length(df_list4)]

initial_energy_mean6 = [mean(df_list6[i][:, "Initial energy"]) for i in 1:length(df_list6)]
first_iter_energy_mean6 = [mean(df_list6[i][:, "First iter energy"]) for i in 1:length(df_list6)]
initial_energy_std6 = [std(df_list6[i][:, "Initial energy"]) for i in 1:length(df_list6)]
first_iter_energy_std6 = [std(df_list6[i][:, "First iter energy"]) for i in 1:length(df_list6)]


p1 = plot(range(1,length(first_iter_energy_mean)),
first_iter_energy_mean, label=L"E_{1}",
marker=:circle, yerror=first_iter_energy_std)
plot!(range(1,length(initial_energy_mean)),
initial_energy_mean, label=L"E_{0}",
marker=:circle, yerror=initial_energy_std)
p3 = plot(range(1,length(first_iter_energy_mean6)),
first_iter_energy_mean6, label=L"E_{1}",
marker=:circle, yerror=first_iter_energy_std6)
plot!(range(1,length(initial_energy_mean6)),
initial_energy_mean6, label=L"E_{0}",
marker=:circle, yerror=initial_energy_std6)


plot(p1, p3)