function [targetXYZ]=SetTarget(startXYZ,A,theta_points)
        global b1 b2 b3
        figuresize = [1024, 768];
        %figure,vis3D(A),title('3D grid and obstacles initial settings');
        f = figure('Name', 'Configuration Space (Obstacles only)', 'position', ...
                   [200, 200, figuresize(1), figuresize(2)]);
        subplot(4, 4, [5, 6, 7, 9, 10, 11, 13, 14, 15] );
        title('Configuration Space (Obstacles only)');
        vis3D_collision(A,0.2,'red');
        %subplot(4, 1, 1);
        % where you start (change to current position later
        voxel( [startXYZ(1) - 0.5, startXYZ(2) - 0.5, startXYZ(3) - 0.5],...
                   [1, 1, 1], 'green', 0.75);       
        pos = -2;
        while pos==-2    
            %%% SLIDER 1
            b1 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                          [128, figuresize(2) - 60, figuresize(1) - 256, 20], ...
                          'value', 1, 'min', 1, ...
                          'max', theta_points, 'Callback', @Slider1_Callback );

            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [96 - 20, figuresize(2) - 60, 40, 20], ...
                      'String', 1); %'BackgroundColor', bgcolor);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 - 20, figuresize(2) - 60, 40, 20], ...
                      'String', theta_points);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 + 20, figuresize(2) - 60, 40, 20], ...
                      'String', get(b1,'Value') );

            %%% SLIDER 2
            b2 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                          [128, figuresize(2) - 120, figuresize(1) - 256, 20], ...
                          'value', 1, 'min', 1, ...
                          'max', theta_points, 'Callback', @Slider2_Callback);

            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [96 - 20, figuresize(2) - 120, 40, 20], ...
                      'String', 1);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 - 20, figuresize(2) - 120, 40, 20], ...
                      'String', theta_points);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 + 20, figuresize(2) - 120, 40, 20], ...
                      'String', get(b2,'Value') );

            %%% SLIDER 3
            b3 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                          [128, figuresize(2) - 180, figuresize(1) - 256, 20], ...
                          'value', 1, 'min', 1, ...
                          'max', theta_points,  'Callback', @Slider3_Callback);

            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [96 - 20, figuresize(2) - 180, 40, 20], ...
                      'String', 1);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 - 20, figuresize(2) - 180, 40, 20], ...
                      'String', theta_points);
            uicontrol('Parent', f, 'Style', 'text', 'Position', ...
                      [figuresize(1) - 96 + 20, figuresize(2) - 180, 40, 20], ...
                      'String', get(b3,'Value') );

            %%% GO BUTTON
            uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', ...
                      [figuresize(1) - 256 + 20, figuresize(2) - 256 - 20 - 64, ...
                       216, 64], 'String', 'GO', 'Callback', @Button_Callback);

            beginGO = 0;

            hold off;
            drawnow;
            %targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];
            while (beginGO == 0)  %%%%% What does this do? %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                pause(0.25);
            %     hold off;
            %     voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
            %            [1, 1, 1], 'blue', 0);
            %     targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];
            %     hold on;
            %     voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
            %            [1, 1, 1], 'blue', 0.75);
            %     
            %    drawnow;
            end

            targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];

            %vis3D_collision(A),title('3D grid and obstacles initial settings');

            %%% add sliders here

            %%% LOOP FOREVER (until exit graph)

            %%% Some callback that checks when GO is pressed

            %%% on GO, take sliders and assign them to targetXYZ and perform search
            %targetXYZ = [10, 10, 10]; % where you end

            % check that targetXYZ is an obstacle!
            pos=A(targetXYZ(1), targetXYZ(2), targetXYZ(3));
            %if (A(targetXYZ(1), targetXYZ(2), targetXYZ(3) ) == -2)
            if pos==-2
            disp('target is an obstacle!');   %%% How to make it display in the current window?
            end
                %voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
                       %[1, 1, 1], 'black', 0.75);
                %return;
                %continue;
            %end
        end
        %% UI setting
    % Slider 1 callback
    function Slider1_Callback(object, ~)
        val = round(b1.Value);
        b1.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 60, 40, 20], ...
          'String', get(b1,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Slider 2 callback
    function Slider2_Callback(object, ~)
        val = round(b2.Value);
        b2.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 120, 40, 20], ...
          'String', get(b2,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Slider 3 callback
    function Slider3_Callback(object, ~)
        val = round(b3.Value);
        b3.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 180, 40, 20], ...
          'String', get(b3,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Button callback
    function Button_Callback(object, ~)
        beginGO = 1;
    end
    

voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
           [1, 1, 1], 'blue', 0.75);
disp('Valid input');
drawnow;
end