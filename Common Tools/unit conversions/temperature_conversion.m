function Tout = temperature_conversion(Tin, targetUnit, OriginalUnit)
switch targetUnit
    case "F"
        switch OriginalUnit
            case "F"
                Tout = Tin;
            case "C"
                Tout = C2F(Tin);
            case "K"
                Tout = K2F(Tin);
            otherwise
                throw(MException([mfilename ':InvalidArgument'], ...
                    'invalid original temperature unit specified'))
        end
    case "C"
        switch OriginalUnit
            case "F"
                Tout = F2C(Tin);
            case "C"
                Tout = Tin;
            case "K"
                Tout = K2C(Tin);
            otherwise
                throw(MException([mfilename ':InvalidArgument'], ...
                    'invalid original temperature unit specified'))
        end
    case "K"
        switch OriginalUnit
            case "F"
                Tout = F2K(Tin);
            case "C"
                Tout = C2K(Tin);
            case "K"
                Tout = Tin;
            otherwise
                throw(MException([mfilename ':InvalidArgument'], ...
                    'invalid original temperature unit specified'))
        end
    otherwise
        throw(MException([mfilename ':InvalidArgument'], ...
            'invalid target temperature unit specified'))
end
end