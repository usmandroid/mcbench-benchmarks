function WAMule_083168(action)

global HandleList   
global muleapp
global app
global points
global mulehit
global StartHandle
global ResetHandle
global Quitcommand
global sound
global SoundHandle

% Check the number of arguments coming in to the function
if nargin==0
    clc
    action=-1;
end;

%==========================================================================
% If action = -1, then INITIALIZE the figure window for the game.
%==========================================================================
if action==-1
    figNumber=figure( ...
        'Name','Whac-A-Mule:  logic programmed by Nate Houle', ...
        'NumberTitle','off', ...
        'DoubleBuffer','on', ...
        'Visible','off', ...
        'Color',[1 .843137 0], ...
        'BackingStore','off');
    axes( ...
        'Units','normalized', ...
        'Position',[0.1 0.1 0.8 0.8], ...
        'Visible','off', ...
        'DrawMode','fast', ...
        'NextPlot','add');

% Information for all buttons
    btnW=0.20; btnH=0.20;
    spacing=0.05;
    btnStart=[0 0 0];
    btnText=[0.99 0.0 0.0];
    btnFont='Arial';
    btnTxtSize=20;

%====================================
% The CONSOLE frame
    frmXc=0.70; frmYc=0.05;
    frmWc=0.25; frmHc=0.9;
    frmPos=[frmXc frmYc frmWc frmHc];
    frmCol=[0 0 .501961];
    CFrameHandle=uicontrol(...
        'Style', 'frame', ...
        'Units', 'normalized', ...
        'Position',frmPos, ...
        'BackgroundColor',frmCol);

%====================================
% Define the START button
% Start button position and label
    xPos1=frmXc+spacing/2;
    yPos1=frmYc+frmHc-spacing-btnH;
    labelStr1='Start';
    cmdStr='start';
    callbackStr='WAMule_083168(0);';

% Define the Start button
    btnPos=[xPos1 yPos1 btnW btnH];
    StartHandle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnStart, ...
        'FontWeight','BOLD', ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'String',labelStr1, ...
        'Interruptible','on', ...
        'Callback',callbackStr);

    
% Define the reset button
% Reset button label
    labelStr1='Reset';
    cmdStr='reset';
    callbackStr='WAMule_083168(-2);';

% Define the reset button
    btnPos=[.72 .54 .1 .1];
    ResetHandle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnStart, ...
        'FontName',btnFont, ...
        'FontSize',12, ...
        'String',labelStr1, ...
        'Interruptible','on', ...
        'Enable', 'on', ...
        'Callback',callbackStr); 
    
% Define the sound button
% Sound button label
    labelStr1='Sound';
    cmdStr='Sound';
    callbackStr='WAMule_083168(-3);';

% Define the Sound button
    btnPos=[.83 .54 .1 .1];
    SoundHandle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',[0 0 0], ...
        'FontName',btnFont, ...
        'FontSize',12, ...
        'String',labelStr1, ...
        'Interruptible','on', ...
        'Enable', 'on', ...
        'Callback',callbackStr); 
        
        
%====================================
% Define the two windows for the total number of mule "whacs"
% Total mules label position and label
    xPos1=frmXc+spacing/2;
    yPos1=frmYc+spacing+btnH*3/2;
    labelStr1='Mules:';

% Define the Total mules label
    btnPos=[xPos1 yPos1 btnW btnH/2];
    TotalLabel=uicontrol(... 
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position',btnPos, ... 
        'ForegroundColor',[0.9 0.9 0.9], ...
        'BackgroundColor',frmCol, ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
		'String', labelStr1);

% Total mules window position and label
    xPos1=frmXc+spacing/2;
    yPos1=frmYc+spacing+btnH;
    labelStr1='0';

% Define the Total mules window
    btnPos=[xPos1 yPos1 btnW btnH/2];
    MulesTextHandle=uicontrol(... 
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position',btnPos, ... 
        'ForegroundColor',btnText, ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'Interruptible','on', ...
		'String', labelStr1);

%====================================
% Define the two windows for the game score
% Score label position and label
    xPos1=frmXc+spacing/2;
    yPos1=frmYc+spacing+btnH/2;
    labelStr1='Score:';

% Define the Score label
    btnPos=[xPos1 yPos1 btnW btnH/2];
    ScoreLabel=uicontrol(... 
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position',btnPos, ... 
        'ForegroundColor',[0.9 0.9 0.9], ...
        'BackgroundColor',frmCol, ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
		'String', labelStr1);

% Score window position and label
    xPos1=frmXc+spacing/2;
    yPos1=frmYc+spacing;
    labelStr1='0';

% Define the Score window
    btnPos=[xPos1 yPos1 btnW btnH/2];
    ScoreTextHandle=uicontrol(... 
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position',btnPos, ... 
        'ForegroundColor',btnText, ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'Interruptible','on', ...
		'String', labelStr1);

%====================================
% The GAMEBOARD frame
    frmXg=0.05; frmYg=0.05;
    frmWg=0.6; frmHg=0.85;
    frmPos=[frmXg frmYg frmWg frmHg];
    frmCol=[0 0 .501961];
    GFrameHandle=uicontrol(...
        'Style', 'frame', ...
        'Units', 'normalized', ...
        'Position',frmPos, ...
        'BackgroundColor',frmCol);
    GonavyDisplay=uicontrol(... 
        'Style', 'text', ...
        'Units', 'normalized', ...
        'Position',[0 8/9 .7 1/9], ...
        'BackgroundColor',[1 .843137 0],...
        'ForegroundColor',[0 0.0 .501961], ...
        'FontName','Arial', ...
        'FontSize',22, ...
        'Interruptible','on', ...
		'String', 'Go Navy! Beat Army!');
%====================================
% Define the individual mule buttons
% Mule button position vectors and labels
    xPos=[frmXg+frmWg/2-btnW/2 frmXg+spacing frmXg+frmWg/2-btnW/2 frmXg+frmWg-spacing-btnW];
    yPos=[frmYg+frmHg-spacing-btnH frmYg+frmHg/2-btnH/2 frmYg+spacing frmYg+frmHg/2-btnH/2];

% Define Button #1
% Setting action to '1' will indicate a successful hit on mule #1.
    callbackStr='WAMule_083168(1);';

    % Generic button information
    btnPos=[xPos(1) yPos(1) btnW btnH];
    Mule1Handle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnText, ...
        'FontAngle','italic', ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'String', 'Mule 1', ...
        'Interruptible','on', ...
        'Enable', 'off', ...
        'Callback',callbackStr);

% Define Button #2
% Setting action to '2' will indicate a successful hit on mule #2.
    callbackStr='WAMule_083168(2);';

    % Generic button information
    btnPos=[xPos(2) yPos(2) btnW btnH];
    Mule2Handle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnText, ...
        'FontAngle','italic', ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'String', 'Mule 2', ...
        'Interruptible','on', ...
        'Enable', 'off', ...
        'Callback',callbackStr);

% Define Button #3
% Setting action to '3' will indicate a successful hit on mule #3.
    callbackStr='WAMule_083168(3);';

    % Generic button information
    btnPos=[xPos(3) yPos(3) btnW btnH];
    Mule3Handle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnText, ...
        'FontAngle','italic', ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'String', 'Mule 3', ...
        'Interruptible','on', ...
        'Enable', 'off', ...
        'Callback',callbackStr);

% Define Button #4
% Setting action to '4' will indicate a successful hit on mule #4.
    callbackStr='WAMule_083168(4);';

    % Generic button information
    btnPos=[xPos(4) yPos(4) btnW btnH];
    Mule4Handle=uicontrol( ...
        'Style','pushbutton', ...
        'Units','normalized', ...
        'Position',btnPos, ...
        'ForegroundColor',btnText, ...
        'FontAngle','italic', ...
        'FontName',btnFont, ...
        'FontSize',btnTxtSize, ...
        'String', 'Mule 4', ...
        'Interruptible','on', ...
        'Enable', 'off', ...
        'Callback',callbackStr);

%====================================
% Set the global HandleList for all graphics elements and uncover the figure
    HandleList=[Mule1Handle Mule2Handle Mule3Handle Mule4Handle StartHandle MulesTextHandle ScoreTextHandle];
    set(figNumber, 'Visible', 'on');
%plays the opening music   
    fox = wavread('foxtheme.wav');
    wavplay(fox,47025)
end

%==========================================================================
% If action = 1-4, then IDENTIFY the mule that was hit, increase score.
%==========================================================================
if action>0 
   points=points+10;
   disp(['Whacked mole number ' num2str(action)])
   mulehit(action)=mulehit(action)+1;
   set(HandleList(7),'string',num2str(points));
   drawnow
end

%==========================================================================
% If action = -2, then reset the game so you can play again.
%==========================================================================
Quitcommand=0;
if action==-2
   points=0;
   app=0;
   muleapp=[0 0 0 0];
   mulehit=[0 0 0 0];
   set(HandleList(6),'string',num2str(app));
   set(HandleList(7),'string',num2str(points));
   set(StartHandle,'enable','on');
   drawnow
   Quitcommand=1;
   if sound==0
       quityou = wavread('quityou.wav');
       wavplay(quityou,45025)
   end
end

%==========================================================================
% If action = -3, then turn the sound off/on
%==========================================================================
if action==-3
   if sound ==0
       sound=1;
       set(SoundHandle,'ForegroundColor',[1 0 0]);
   else 
       sound=0;
       set(SoundHandle,'ForegroundColor',[0 0 0]);
   end
end
%==========================================================================
% If action = 0, then START the game.
%==========================================================================
if action==0
    % ifthe sound is on play "lets get ready to rumble", if off then wait a
    % time before showing the first mule.
    if sound==0
        rumble = wavread('rumble.wav');
        wavplay(rumble,45025)
    else
       waittime =rand;
       tic
       while toc<waittime
           drawnow
       end   
    end
     
   %the part where he mules appear
   while app<10 & Quitcommand~=1
       %selects a random mule between 1 and 4 
       mulenum = floor(3.9999999*rand +1);
       muleapp(mulenum)=muleapp(mulenum)+1;
   
       %selects random time and pause time
       randtime=rand+.2;
       pausetime =.5*rand;
       set(HandleList(mulenum),'enable','on')
       app=app+1;
       set(HandleList(6),'string',num2str(app));
       drawnow
       tic
       while toc<randtime
           drawnow
       end
       
       %reset all the mules to off
       set(HandleList(mulenum),'enable','off');
       
       %wait the pause time before reruning the loop
       tic
       while toc<pausetime
           drawnow
       end             
   end
   
   %Turns the Start button off so you can't start again without hitting
   %reset
   set(StartHandle,'enable','off');
   %draws the stats window
   Statswindow()
   drawnow
   %plays your win/loose song
   if sound==0
       Randomsong()
   end
   
   
   
   %still displays the game stats to the Matlab window
   disp(['Your score was ',num2str(points)]);
   disp(['Mule 1 appeared ',num2str(muleapp(1)),' times']);
   disp(['Mule 2 appeared ',num2str(muleapp(2)),' times']);
   disp(['Mule 3 appeared ',num2str(muleapp(3)),' times']);
   disp(['Mule 4 appeared ',num2str(muleapp(4)),' times']);
   disp(['Mule 1 was hit ',num2str(mulehit(1)),' times']);
   disp(['Mule 2 was hit ',num2str(mulehit(2)),' times']);
   disp(['Mule 3 was hit ',num2str(mulehit(3)),' times']);
   disp(['Mule 4 was hit ',num2str(mulehit(4)),' times']);
   
end