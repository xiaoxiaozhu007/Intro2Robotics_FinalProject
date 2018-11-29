function[errorCode]=adjpostest(a, vol_end, en_pin, dir_pin, pot_pin, opp_pot, timeout)
tic
while (toc < timeout)

    vol_read = readVoltage(a, pot_pin);

    vol_diff = abs(vol_end - vol_read);

    while ( (vol_diff > 0.05) && (toc < timeout) )
        if (vol_read > vol_end)
            % in the process of lowering voltage
            writeDigitalPin(a, dir_pin, xor(opp_pot, 0) );

        else
            % in the process of raising voltage
            writeDigitalPin(a, dir_pin, xor(opp_pot, 1) );
        end

        if (vol_diff > 1)
            writePWMVoltage(a, en_pin, 4);

        else if (vol_diff > 0.25)
                if (en_pin == 'D3')
                    writePWMVoltage(a, en_pin, 3);
                else
                    %writePWMVoltage(a, en_pin, 2);
                    if (en_pin == 'D6')
                       writePWMVoltage(a, en_pin, 3);
                    
                    else
                        writePWMVoltage(a, en_pin, 2);
                    end
                end
                %writePWMVoltage(a, en_pin, 2);
                
            else
                if (en_pin == 'D7')
                    writePWMVoltage(a, en_pin, 2);
                else                    
                    if (en_pin == 'D6')
                        writePWMVoltage(a, en_pin, 2.5);
                        
                    else
                        writePWMVoltage(a, en_pin, 1.5);
                        %writePWMVoltage(a, en_pin, 1);
                    end
                end
            end

        end

        vol_read = readVoltage(a, pot_pin);
        vol_diff = abs(vol_end - vol_read);
    end
    
    writePWMVoltage(a, en_pin, 0);
end

%writePWMVoltage(a, en_pin, 0);

errorCode = 0;

end