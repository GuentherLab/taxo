%%%% plot examples of unimodal/bimodal distributions for illustration purposes

%% unimodal
subplot(1,2,1)
x = randn(1000000,1);
y = randn(30000,1);
histogram([x;y],100)
xline(2.2)
set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})
box off
title ('Unimodal distribution')
ylabel('Population frequency')
xlabel('Stuttering measure')
xlim([-4 4])

%% bimodal
subplot(1,2,2)
x = randn(1000000,1);
y = randn(20000,1)/3 + 4;
histogram([x;y],100)
xline(3.2)
set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})
box off
title('Bimodal distribution')
xlabel('Stuttering measure')
xlim([-4 6])