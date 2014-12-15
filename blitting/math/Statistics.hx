package blitting.math;

class Statistics {

    public static function probability(occurred:Float, outcomes:Float):Bool {
        return Math.random() * outcomes < occurred;
    }

}
