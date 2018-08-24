dt = 0.06;        % time step
L = 0.68;         % length of the car


load test.path
data = test(round(linspace (1,404,7)),:) - test(1,:);
s = data;


kGains = [0.1,0.1];
tspan = 0:dt:10.8;
tsplit = [1 round(1.8/dt) round(3.6/dt) round(5.4/dt) round(7.2/dt) round(9.0/dt) size(tspan,2)];
[state,control] = plan_car_trajectory2(L,s,kGains,tspan,dt,tsplit);

output_trajectory([0; 0; 0; 0], state, control, 'demo2.txt');


%%% --------------------------------


load demo2.txt

states = demo2(:, 1:4);
controls = demo2(:, 5:6);
sim_states = [];
dt = 0.01;
len = 0.68;

state = states(1,:);
for i = 1:size(controls,1);
    v = controls(i,1);
    w = controls(i,2);

    for j = 1:6;
        state = [
            state(1) + cos(state(3)) * v * dt
            state(2) + sin(state(3)) * v * dt
            state(3) + (tan(state(4)) * v * dt)/len
            state(4) + w * dt]';
        sim_states = [sim_states; state];
    end
end


%%% --------------------------------


figure
hold on
plot (states(:,1), states(:,2), 'b')
plot (sim_states(:,1), sim_states(:,2), 'r')
hold off
