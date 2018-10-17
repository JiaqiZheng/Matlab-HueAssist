function readLights(mTimer,~)
    LightsInfo = webread("http://"+mTimer.UserData(1)+"/api"+mTimer.UserData(2)+"/lights");
    if (LightsInfo.x3.state.on==1)
        on = "on";
    else 
        on = "off";
    end
    currentTime=clock;
    disp("current time");
    disp(currentTime(4:end));
    disp(["light 3" on "bright" LightsInfo.x3.state.bri]);
    
end
