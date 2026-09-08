{
    programs.walker = {    
        enable = true;
        runAsService = true;
    };
    config = {
        providers.prefixes = [
            {
                provider = "bitwarden";
                prefix = "bw";
            }
        ];
    };
} 
