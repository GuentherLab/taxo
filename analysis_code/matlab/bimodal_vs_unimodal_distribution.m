%%%% plot examples of unimodal/bimodal distributions for illustration purposes




%% unimodal
n_subs = 1e6; 
threshval = 2.2; % draw vert line here
nbins = 100; 
xlimits = [-4 4];

subplot(1,2,1)
x = randn(n_subs,1);
histogram(x,nbins)
% xline(threshval)
set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})
box off
% title ('Unimodal distribution')
ylabel('Population frequency')
% xlabel('Stuttering measure')
xlim(xlimits)

%% bimodal - exaggerated
n_nonstutterers = 1e6; 
n_stutterers = 2e4; 
    stutterer_width_factor = 1/3; 
    stutterer_offset = 4; 
threshval = 3.2; % draw vert line here
nbins = 100;
xlimits = [-4 6];

subplot(1,2,2)
x = randn(n_nonstutterers,1);
y = randn(n_stutterers,1) * stutterer_width_factor + stutterer_offset;
histogram([x;y],nbins)
% xline(threshval)
set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})
box off
% title('Bimodal distribution')
% xlabel('Stuttering measure')
xlim(xlimits)
