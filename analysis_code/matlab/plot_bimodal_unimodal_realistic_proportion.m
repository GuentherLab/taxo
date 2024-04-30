% plot bimodal and unimodal distributions of stuttering, using realistic
% values for percent of stutterers

close all
hfig = figure;

ops.sigma = 0.28; 
ops.nbins = 100; 
ops.xlabel = '% syllables stuttered';
ops.vertline_style = '--';
    ops.vertline_color = [0.5 0.5 0.5];
ops.hist_edge_alpha = 0.3; 
ops.topmargin_proportion = 0.3; % set ymax to this proportion above max values

%% unimodal
ops.n_nonstutterers = 1e6; 
    ops.nonstutterer_mean = 1; 
ops.n_stutterers = 0.05 * ops.n_nonstutterers; % use 5% for percent stuttering children
ops.cohens_d = 0; 
ops.xlimits = [-4 6];
ops.plotnum = 1; 
ops.title = {'Unimodal';['(d = ',num2str(ops.cohens_d),')']};
makeplot(ops)

%% bimodal - realistic
ops.n_nonstutterers = 1e6; 
    ops.nonstutterer_mean = 1; 
    
ops.n_stutterers = 0.05 * ops.n_nonstutterers; % use 5% for percent stuttering children
ops.cohens_d = 2; 
ops.threshval = 3.2; % draw vert line here
ops.xlimits = [-4 6];
ops.plotnum = 2; 
ops.title = {'Bimodal - realistic';['(d = ',num2str(ops.cohens_d),')']};

makeplot(ops)

%% bimodal - exaggerated
ops.n_nonstutterers = 1e6; 
    ops.nonstutterer_mean = 1; 
ops.n_stutterers = 0.05 * ops.n_nonstutterers; % use 5% for percent stuttering children
ops.cohens_d = 4; 
ops.threshval = 3.2; % draw vert line here
ops.xlimits = [-4 6];
ops.plotnum = 3; 
ops.title = {'Bimodal - exaggerated';['(d = ',num2str(ops.cohens_d),')']};

makeplot(ops)



%%
function makeplot(ops)


subplot(1,3,ops.plotnum)
ops.stutterer_mean = ops.nonstutterer_mean + ops.sigma*ops.cohens_d; 
pwns_dat = normrnd(ops.nonstutterer_mean, ops.sigma, ops.n_nonstutterers,1);
pws_dat = normrnd(ops.stutterer_mean, ops.sigma, ops.n_stutterers,1);
plotdat = max([pwns_dat;pws_dat],0);
hhist = histogram(plotdat,ops.nbins);
    hhist.EdgeAlpha = ops.hist_edge_alpha; 

pws_xline = xline(ops.stutterer_mean,"LineStyle",ops.vertline_style,"Color",ops.vertline_color );
pwns_xline = xline(ops.nonstutterer_mean,"LineStyle",ops.vertline_style,"Color",ops.vertline_color );

% set(gca,'XTickLabel',{})
set(gca,'YTickLabel',{})
box off
title(ops.title)
xlabel(ops.xlabel)
% xlim(ops.xlimits)

ylim([0, [1+ops.topmargin_proportion]*max(hhist.Values)])

end
