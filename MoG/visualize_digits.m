function junk = visualize_digits(mu,vary)
    hold on
    figure
    
    c = 25;
    number_pics = size(mu,3);
    for i = 1:number_pics
        subplot(number_pics,2,2*i-1)
        imagesc(reshape(mu(:,c,i),16,16))
        title('Mean of cluster')
        subplot(number_pics,2,2*i)
        imagesc(reshape(vary(:,c,i),16,16))
        title('Variance of cluster')
        hold on
    end
    hold off
end