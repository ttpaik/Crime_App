%GUI with a scatter plot of stock name and prices, text boxes displaying
%the minimum and maximum of stock prices and their companies; there are
%also push buttons that lead the user into more specific features.
function epicpro
endpoints = 'https://data.cityofboston.gov/resource/29yf-ye7n.json';
resp = webread(endpoints,'year','2016');

minla = 42.318970;
maxla = 42.391800;
minlg = -71.186416;
maxlg = -70.995700;

for i = length(resp):-1:1
    if isfield(resp{i},'lat') && isfield(resp{i},'long')
    if minla < str2double(resp{i}.lat) && maxla > str2double(resp{i}.lat) && ...
            minlg < str2double(resp{i}.long) && maxlg > str2double(resp{i}.long)
        rawdata{i} = resp{i};
        la(i) = str2double(resp{i}.lat);
        lg(i) = str2double(resp{i}.long);
    end
    end
end
rawdata= rawdata(~cellfun('isempty',rawdata));






assn = [801,802,400:433];
robn = [301:380];
larn = [616:649];
auton = [701:790];
for i = length(rawdata):-1:1
    if ~isempty(rawdata{i})
    if ismember(str2double(rawdata{i}.offense_code),assn)
        assault{i} = rawdata{i};
    elseif ismember(str2double(rawdata{i}.offense_code),robn)
        robbery{i} = rawdata{i};
    elseif ismember(str2double(rawdata{i}.offense_code),larn)
        larceny{i} = rawdata{i};
    elseif ismember(str2double(rawdata{i}.offense_code),auton)
        autotft{i} = rawdata{i};
    end
    end
end





robbery = robbery(~cellfun('isempty',robbery));
assault = assault(~cellfun('isempty',assault)); 
larceny = larceny(~cellfun('isempty',larceny)); 
autotft = autotft(~cellfun('isempty',autotft)); 




crimetype = {'Robbery','Assault','Larceny','Auto Theft'};
crimenum = [length(robbery),length(assault),length(larceny),length(autotft)];
crimemin = sprintf('%s is least likely to happen\n', crimetype{find(crimenum == min(crimenum))});
crimemax = sprintf('%s is most likely to happen\n', crimetype{find(crimenum == max(crimenum))});








f=figure('Visible','off','color','white','Units','Normalized','Position',[.05,.05,.8,.8]);
fmax=uicontrol('Style','text','Units','Normalized','Position',[.042 .90 .11 .04],'FontSize',12,'BackgroundColor','w','String','MAX');
fmin=uicontrol('Style','text','Units','Normalized','Position',[.042 .78 .11 .04],'FontSize',12,'BackgroundColor','w','String','MIN');
fmaxval=uicontrol('Style','text','Units','Normalized','Position',[.035 .82 .11 .08],'FontSize',10,'BackgroundColor','w','String',crimemax);
fminval=uicontrol('Style','text','Units','Normalized','Position',[.033 .70 .11 .08],'FontSize',10,'BackgroundColor','w','String',crimemin);
myloc=uicontrol('Style','pushbutton','Units','Normalized','Position',[.05 .40 .11 .08],'FontSize',12,'String','Current Location','Callback',@loc);
fsaf=uicontrol('Style','pushbutton','Units','Normalized','Position',[.05 .25 .11 .08],'FontSize',12,'String','Safety Alert','Callback',@safecheck);
fmap=uicontrol('Style','text','Units','Normalized','Position',[.05 .025 .11 .08],'FontSize',12,'BackgroundColor',[1 1 1],'String','Map specification');
fmap1=uicontrol('Style','pushbutton','Units','Normalized','Position',[.20 .05 .11 .08],'FontSize',12,'String','Robbery','Callback',@matc);
fmap2=uicontrol('Style','pushbutton','Units','Normalized','Position',[.35 .05 .11 .08],'FontSize',12,'String','Assault','Callback',@matc);
fmap3=uicontrol('Style','pushbutton','Units','Normalized','Position',[.50 .05 .11 .08],'FontSize',12,'String','AutoTheft','Callback',@matc);
fmap4=uicontrol('Style','pushbutton','Units','Normalized','Position',[.65 .05 .11 .08],'FontSize',12,'String','Larceny','Callback',@matc);
fmap5=uicontrol('Style','pushbutton','Units','Normalized','Position',[.80 .05 .11 .08],'FontSize',12,'String','Back to All','Callback',@matc);
axhan=axes('Units','Normalized','Position',[.2 .2 .79 .79]);
I = imread('bosmap.jpg');
I = I*0.95;
image([-71.186416  -70.995700],[42.318970 42.391800],I);
ylabel('Latitude');
xlabel('Longitude');
hold on






for i = length(robbery):-1:1
        lar(i) = str2double(robbery{i}.lat);
        lgr(i) = str2double(robbery{i}.long);
end
rob = plot(lgr,lar,'g.','MarkerSize',20);
for i = length(assault):-1:1
        laa(i) = str2double(assault{i}.lat);
        lga(i) = str2double(assault{i}.long);
end
ass = plot(lga,laa,'r*');

for i = length(larceny):-1:1
        lal(i) = str2double(larceny{i}.lat);
        lgl(i) = str2double(larceny{i}.long);
end
lac = plot(lgl,lal,'ko','LineWidth',1.5);
for i = length(autotft):-1:1
        laa(i) = str2double(autotft{i}.lat);
        lga(i) = str2double(autotft{i}.long);
end
auto = plot(lga,laa,'m+','LineWidth',1.5);

all= plot(lg,la,'b.','MarkerSize',10);
legend('Robbery','Assault','Larceny','Auto Theft','All crime');





f.Visible = 'on';

function matc(hObject,eventdata) 
    if hObject == fmap1
        ass.Visible = 'off';
        rob.Visible = 'on';
        lac.Visible = 'off';
        auto.Visible = 'off';
        all.Visible = 'off';
    elseif hObject == fmap2
        rob.Visible = 'off';
        ass.Visible = 'on';
        lac.Visible = 'off';
        auto.Visible = 'off';
        all.Visible = 'off';
    elseif hObject == fmap3
        ass.Visible = 'off';
        rob.Visible = 'off';
        lac.Visible = 'off';
        auto.Visible = 'on';
        all.Visible = 'off';
    elseif hObject == fmap4
        ass.Visible = 'off';
        rob.Visible = 'off';
        lac.Visible = 'on';
        auto.Visible = 'off';
        all.Visible = 'off';
    elseif hObject == fmap5
        ass.Visible = 'on';
        rob.Visible = 'on';
        lac.Visible = 'on';
        auto.Visible = 'on';
        all.Visible = 'on';
    end
end

function loc(hObject,eventdata)
m = mobiledev();
m.Logging=1;
while m.logging
    pause(1);
    y = m.latitude;
    x = m.longitude;
    hold on
    plot(x,y,'o','MarkerSize',50);    
end
end


function safecheck(hObject,eventdata)
m = mobiledev;
while ~m.logging
    disp('please start sending');
    pause(5);
end
surround = {};
while m.logging
    y = m.latitude; y0=y-1; y1=y+1;
    x = m.longitude; x0=x-1; x1=x+1;
   for i = length(rawdata):-1:1
       if (y0 < str2double(rawdata{i}.lat)) && (y1 > str2double(rawdata{i}.lat)) && ...
            (x0 < str2double(rawdata{i}.long)) && (x1 > str2double(rawdata{i}.long))
        surround{i} = rawdata{i};
       end
   end
   surround = surround(~cellfun('isempty',surround));
   if length(surround)>5
       disp('abnormal intensity of crime detected in this area, please be cautious');
   end
   pause(30)
end
end

end