%%%% stimulate latent variable, index indicator variable, and nonindex indicator variable relationship in different portions....
% ....... of a simulated distribution of stutterers and nonstutterers
% This is an simulation of a MAXCOV taxometric analysis
% 
% we may use an unrealistically large number of PWS and large separation between PWS vs PWNS for visual clarity
%
% the index indicator variable (x) and nonindex indicator variable (y) variable will be equal to the latent index variable ("latent") plus gaussian noise
%
%%%% plot the covariance between x and y in a window moving across the distribution
%
% the main purpose of this script is to test whether maxcov will find a covariance peak from a bimodally distributed latent variable 
% .....(and not a unimodally distributed one)

clear

%% params
% distribution params
n_nonstutterers = 10^4;
n_stutterers = 10^3;
group_latent_values = [0 0]; % [nonstuttering latent, stuttering latent]
x_sigma = 1; 
y_sigma = 1; 

% window params
window_size = 0.5;
window_stride = 0.05; 
window_minmax = group_latent_values + [-3 3];
    % window_minmax = [-3 6]; 

cov_plot_y_angle = 0; 
hist_plot_y_angle = 0; 
histogram_xlabel = 'Indicator value (z-score)'; 
cov_ylims = [-0.1 0.1];

%%%%%  generic labels - not stuttering-specific
index_var_name = 'index_var'; 
nonindex_var_name = 'nonindex_var'; 
cov_plot_xlabel = 'indicator variable value window center'; 
cov_plot_ylabel = 'indicator-nonindicator covariance'; 

%%%%% stuttering-specific example labels
index_var_name = 'SLDs per 100 syllables'; 
nonindex_var_name = 'Units per repetition instance'; 
cov_plot_xlabel = 'Window center - SLDs/100 (z-score)'; 
cov_plot_ylabel = {'Covariance between', 'SLDs/100' 'and Rep. Units'}; 

%% make distributions and get covariance
% create overall distributions
subs = table([zeros(round(n_nonstutterers),1)+group_latent_values(1); zeros(round(n_stutterers),1)+group_latent_values(2)],...
    'VariableNames',{'latent'});
subs.x = normrnd(subs.latent,x_sigma);
subs.y = normrnd(subs.latent,y_sigma);

% covariance in moving window
%%% window centers are equally spaced across values of x, and thus will contain different numbers of elements
window_centers = window_minmax(1):window_stride:window_minmax(2);
n_win_cents = length(window_centers);
covr = nan(1,n_win_cents);
for iwin = 1:n_win_cents
   winlims = [window_centers(iwin) - window_size, window_centers(iwin) + window_size];
   subinds_in_this_window = subs.x > winlims(1) & subs.x < winlims(2);
   cov_this_win = cov(subs.x(subinds_in_this_window), subs.y(subinds_in_this_window));
   covr(iwin) = cov_this_win(2,1);
end


%% plotting
% indicator variable histograms overlaid
tiledlayout(2,1)
nexttile
histogram(subs.x)
box off
hold on
histogram(subs.y,'FaceAlpha',0.5)
xline(group_latent_values(1),'--') % pwns mean
xline(group_latent_values(2),'--') % pws mean
legend({index_var_name,nonindex_var_name},'Interpreter','none')
set(gca,'YTickLabel',{})
hist_hylab =  ylabel({'Population', 'frequency'});
    hist_hylab.Rotation = hist_plot_y_angle;
xlabel(histogram_xlabel)
hist_xlim = xlim;

% covariance across windows
nexttile
plot(window_centers,covr)
box off
xline(group_latent_values(1),'--') % pwns mean
xline(group_latent_values(2),'--') % pws mean
xlim(hist_xlim)
xlabel(cov_plot_xlabel)
cov_hylab = ylabel(cov_plot_ylabel);
    cov_hylab.Rotation = cov_plot_y_angle;
if ~isempty(cov_ylims)
    ylim(cov_ylims)
end


set(gcf,'color','w');
hax = gca; 
tightinset = get(hax,'TightInset');
set(hax, 'Position', [tightinset(1:2), 1-tightinset(1)-tightinset(3), 1-tightinset(2)-tightinset(4)])
