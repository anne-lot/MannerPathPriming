function [response] = Sample_Trial(trialNo)


    global parameters
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOVIES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Noun training
    movietoplay_noun1a = 'Movies/1_noun_1a.mov';
    movietoplay_noun1b = 'Movies/1_noun_1b.mov';
    movietoplay_noun1_distractor = 'Movies/1_noun_1_distractor';
    movietoplay_noun2a = 'Movies/2_noun_2a.mov';
    movietoplay_noun2b = 'Movies/2_noun_2b.mov';
    movietoplay_noun2_distractor = 'Movies/2_noun_2_distractor';

    %Trial movies
    movietoplay_target = strcat('Movies/', char(parameters.pbiasV(trialNo)));
    movietoplay_distractor = strcat('Movies/', char(parameters.mbiasV(trialNo)));
    movietoplay_sign = strcat('Movies/', char(parameters.ambigV(trialNo)));
    movietoplay_trainV1 = strcat('Movies/', char(parameters.trainV1(trialNo)));
    movietoplay_trainV2 = strcat('Movies/', char(parameters.trainV2(trialNo)));
    movietoplay_trainV3 = strcat('Movies/', char(parameters.trainV3(trialNo)));
    movietoplay_mTest = strcat('Movies/', char(parameters.mtestV(trialNo)));
    movietoplay_pTest = strcat('Movies/', char(parameters.ptestV(trialNo)));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AUDIO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    soundtoplay_ambigAudioFuture = strcat('Audio_stimuli_creation/Finished/', char(parameters.ambigAudioFuture(trialNo)));
    soundtoplay_ambigAudioPast = strcat('Audio_stimuli_creation/Finished/', char(parameters.ambigAudioPast(trialNo)));
    soundtoplay_trainAudioFuture1 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioFuture1(trialNo)));
    soundtoplay_trainAudioPast1 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioPast1(trialNo)));
    soundtoplay_trainAudioFuture2 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioFuture2(trialNo)));
    soundtoplay_trainAudioPast2 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioPast2(trialNo)));
    soundtoplay_trainAudioFuture3 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioFuture3(trialNo)));
    soundtoplay_trainAudioPast3 = strcat('Audio_stimuli_creation/Finished/', char(parameters.trainAudioPast3(trialNo)));
    soundtoplay_whichOne = strcat('Audio_stimuli_creation/Finished/', char(parameters.whichOne(trialNo)));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    %Clear screen
    Show_Blank;
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIAS TEST VIDEO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

finishedSignMovie = 0;
    
    while not(finishedSignMovie)
        
          Show_Blank;



        Play_Sound(soundtoplay_ambigAudioFuture, 'toBlock');
    
        PlayCenterMovie(movietoplay_sign);

        Play_Sound(soundtoplay_ambigAudioPast, 'toBlock');

        %Decide if we should we watch again?
        Text_Show('Press r to see again. If not, press space');
        response_sign = Take_Response();
        
            if response_sign == 'r'
                finishedSignMovie = 0;
                 else
                finishedSignMovie = 1;
            end
        
        Show_Blank; 
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % BIAS TEST
    % Play the two event movies; movie always plays L then R
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            Play_Sound(soundtoplay_whichOne, 'toBlock');
            Show_Blank;
     
    if parameters.LorR_bias == 0 %play Target Movie on left

        Show_Blank;
        PlaySideMovies(movietoplay_target,'','caption_left','Z');
        Show_Blank;
        PlaySideMovies('',movietoplay_distractor,'caption_right','X');

    else %play Distractor Movie on left

        Show_Blank;
        PlaySideMovies(movietoplay_distractor,'','caption_left','Z');
        Show_Blank;
        PlaySideMovies('',movietoplay_target,'caption_right','X');

    end
    
    parameters.biasTestAns(trialNo) = Take_Response();
    Show_Blank();
    
    
    %%%%
    %Play the sign movie again
    %%%%
    %Show_Blank;
    %PlayCenterMovie(movietoplay_sign);
    
    %And prompt and record the response!
    Text_Show('Which one is ...');
    response = Take_Response();
    Show_Blank;
    
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3 TRAINING VIDEOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Text_Show('(((training phase)))');
Take_Response();
Show_Blank;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 111111111111111111111111111111111111111111111111111111111111111111111111
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameters.trainingStart(trialNo) = GetSecs;

Play_Sound(soundtoplay_trainAudioFuture1, 'toBlock');

PlayCenterMovie(movietoplay_trainV1);
PlayCenterMovie(movietoplay_trainV1);

Play_Sound(soundtoplay_trainAudioPast1, 'toBlock');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2222222222222222222222222222222222222222222222222222222222222222222222222
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Play_Sound(soundtoplay_trainAudioFuture2, 'toBlock');


PlayCenterMovie(movietoplay_trainV2);
PlayCenterMovie(movietoplay_trainV2);


Play_Sound(soundtoplay_trainAudioPast2, 'toBlock');
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 333333333333333333333333333333333333333333333333333333333333333333333333%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Play_Sound(soundtoplay_trainAudioFuture3, 'toBlock');

PlayCenterMovie(movietoplay_trainV3);
PlayCenterMovie(movietoplay_trainV3);

Play_Sound(soundtoplay_trainAudioPast3, 'toBlock');

parameters.trainingEnd(trialNo) = GetSecs;

Show_Blank;
Take_Response();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLAY THE TEST MOVIE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%Text_Show('(((which one is ....)))');
%Take_Response();
%Show_Blank;


parameters.finalTest(trialNo) = GetSecs;


Play_Sound(soundtoplay_whichOne, 'toBlock');
Take_Response();
Show_Blank;


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
     if parameters.LorR_final == 0 %play Target Movie on left

        Show_Blank;
        PlaySideMovies(movietoplay_mTest,'','caption_left','Z');
        Show_Blank;
        PlaySideMovies('',movietoplay_pTest,'caption_right','X');

    else %play Distractor Movie on left

        Show_Blank;
        PlaySideMovies(movietoplay_pTest,'','caption_left','X');
        Show_Blank;
        PlaySideMovies('',movietoplay_mTest,'caption_right','Z');
        Show_Blank;

     end
     
  parameters.finalTestAns(trialNo) = Take_Response();
  parameters.finalEnd(trialNo) = GetSecs;  

    
end




