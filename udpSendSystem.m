classdef udpSendSystem < matlab.System
    % Blok systemowy do wysyłania wiadomości UDP w Simulinku

    % Właściwości (zmienne) klasy
    properties (Nontunable)
        IP = '25.50.49.55';  % Adres IP odbiorcy
        Port = 5024;          % Port odbiorcy
    end

    properties (Access = private)
        udpSocket;  % Prywatne gniazdo UDP
    end

    methods (Access = protected)
        % Setup – inicjalizacja gniazda UDP
        function setupImpl(obj)
            obj.udpSocket = dsp.UDPReceiver('RemoteIPAddress', obj.IP, ...
                                            'RemoteIPPort', obj.Port);
        end

        % Funkcja krokowa – wysyłanie wiadomości
        function stepImpl(obj, message)
            data = uint8(char(message));
            send(obj.udpSocket, data);
        end

        % Cleanup – zamykanie gniazda UDP
        function releaseImpl(obj)
            release(obj.udpSocket);
        end
    end
end
