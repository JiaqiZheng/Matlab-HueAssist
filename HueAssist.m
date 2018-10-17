%%initialization 
%%this works in really network
%UserData = webread("https://discovery.meethue.com/");
%ipAddress = UserData.internalipaddress;
%%for fake net work manually get the ip of your computer
ipAddress ="192.168.1.2";
%%

%%
post = struct('devicetype','my_hue_app#iphone peter');
InitOptions = weboptions('MediaType','application/json');
responce = webwrite("http://"+ipAddress+"/api",post,InitOptions);
%%manually press the botton on bridge 
responce = webwrite("http://"+ipAddress+"/api",post,InitOptions);
username = responce.success.username;
%%

%Testing
%%READ DATA:
%%This will give all the information of light. The data will be stored in
%%the struct name "LightsIno"
LightsInfo = webread("http://"+ipAddress+"/api"+username+"/lights");
%%CONTROL LIGHTS
%%example of controlling light for light number "3" set it to on
LightID = "3";
SetLightOptions = weboptions('MediaType','application/json','RequestMethod','put');
SetInfo=struct('hue',2000);
SetLights = webwrite("http://"+ipAddress+"/api/"+username+"/lights/"+LightID+"/state",SetInfo,SetLightOptions);

%Real time reading
%if you want to read the lights date for multiple times, you can use the
%timer in matlab
t = timer;
t.UserData = [ipAddress, username];
t.StartFcn = @(~,thisEvent)disp([thisEvent.Type ' executed '...
    datestr(thisEvent.Data.time,'dd-mmm-yyyy HH:MM:SS.FFF')]);
t.TimerFcn = @readLights;
t.StopFcn = @(~,thisEvent)disp([thisEvent.Type ' executed '...
    datestr(thisEvent.Data.time,'dd-mmm-yyyy HH:MM:SS.FFF')]);
t.Period = 1;
t.TasksToExecute = 60;
t.ExecutionMode = 'fixedRate';
start(t)

delete(t)
