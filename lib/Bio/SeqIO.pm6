use v6;

use Bio::Role::Pluggable;
use Bio::Role::SeqStream;
use Bio::Role::RecordFormat;

class Bio::SeqIO does Bio::Role::Pluggable['SeqIO'] does Bio::Role::RecordFormat does Bio::Role::SeqStream {
    
    submethod BUILD(:$!format!) {
        
        if $!format ~~ / <[-]> / {
            ($!format, $!format-variant) = $!format.split: '-', 2;
        }
        
        my $plugin = "Bio::SeqIO::" ~ $!format.lc;
        
        try {
            require $plugin;
        };
        
        if ::($plugin) ~~ Failure {
            die "Can't load $plugin: $!";
        } else {
            self does ::($plugin);
        }
        # mix in the plugin module
    }
    
    method next-Seq { ... }
    
    method write-Seq { ... }
    
    method guess-format { ... }
}
