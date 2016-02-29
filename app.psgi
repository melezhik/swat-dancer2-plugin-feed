use Dancer2;
use Dancer2::Plugin::Feed;
use Try::Tiny;
 
get '/feed/:format' => sub {
    my $feed;
    try {
        $feed = create_feed(
            format  => params->{format},
            title   => 'my great feed',
            entries => [ map { title => "entry $_" }, 1 .. 10 ],
        );
    }
    catch {
        my ( $exception ) = @_;
 
        if ( $exception->does('FeedInvalidFormat') ) {
            return $exception->message;
        }
        elsif ( $exception->does('FeedNoFormat') ) {
            return $exception->message;
        }
        else {
            $exception->rethrow;
        }
    };
 
    return $feed;
};
 
dance;

