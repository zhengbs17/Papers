function mpc = case_EHs_7days

mpc.N_EH = 3;
Day = 7
tau = 1/4

NT = Day * 24 / tau

mpc.tau = tau;
mpc.T = NT;
mpc.Day = Day;

%% CHP
% EH Index(1)|Capacity/MW(2)|Efficiency of Gas-to-Power(3)|Efficiency of Gas-to-Heat(4)
mpc.CHP_data = [
    1    5    0.35   0.45 ;
    2    5    0.35   0.45 ;
    3    5    0.35   0.45 ;
    ];

%% Heat Pump
% EH Index(1)|Capacity(2)|COP(3)
mpc.HP_data = [% MW
    1    10     3
    2     8     3
    3     9     3
    ];
%% Battery Storage Unit
% EH Index(1)|Charging Efficiency(2)|Discharging Efficiency(3)|Capacity(MWh)(4)
mpc.ESU_data = [  % MWºÍMWh
    1     0.98     0.98       20 ;    
    2     0.98     0.98       20  ;  
    3     0.98     0.98       20  ;   
    ];

%% Heat Storage Unit
% EH Index(1)|Charging Efficiency(2)|Discharging Efficiency(3)|Capacity(MWh)(4)
mpc.HSU_data = [  % MWºÍMWh
    1    0.95     0.95      10    ;
    2    0.95     0.95      10    ;
    3    0.95     0.95      10    ;
    ];

%% Electric Load
%     EH Index(1)|Capacity MW(2)
mpc.PL_data = [
    1    8;
    2    7;
    3    5;
    ]
load E_curve_EHs
mpc.E_curve0 = E_curve_EHs;

%% Heat Load
%     EH Index(1)|Capacity MW(2)
mpc.HL_data = [
    1    5;
    2    4;
    3    3;
    ]
load H_curve_EHs
mpc.H_curve0 = H_curve_EHs;

%% Renewable Generation Curve
% EH Index(1)| Capacity MW(2)
mpc.wind_data = [ % MW
    1    15
    2    5
    3    20
    ];
load renew_curve_EHs
mpc.wind_curve0 = renew_curve_EHs;

%% Price Curve
load E_buy_price_7days
mpc.E_buy_price0 = E_buy_price_7days;

mpc.E_sell_price = 30 * ones(1, NT); % $/MWh
mpc.Gas_buy_price = 50 * ones(1, NT); % $/MWh

mpc.E_curve = zeros(mpc.N_EH,NT);
mpc.H_curve = zeros(mpc.N_EH,NT);
mpc.wind_curve = zeros(mpc.N_EH,NT);
mpc.E_buy_price = zeros(1,NT);
reso = 1/tau;

for t = 1 : 24*Day
    for i = 1 : reso
    mpc.E_curve(:,reso*(t-1)+i) = mpc.E_curve0(:,t);
    mpc.H_curve(:,reso*(t-1)+i) = mpc.H_curve0(:,t);
    mpc.wind_curve(:,reso*(t-1)+i) = mpc.wind_curve0(:,t);
    mpc.E_buy_price(:,reso*(t-1)+i) = mpc.E_buy_price0(:,t);
    end
end



