package com.blitting.math;
import openfl.geom.Point;
import openfl.geom.Rectangle;

class Geometry {

/**
     * Convert radians to degrees.
     */
    public static function deg2rad(angle:Float):Float {
        angle = !Math.isNaN(angle) ? (angle) : (0);

        return angle * Math.PI / 180;
    }

/**
     * Distance between two points within the same
     * coordinate system.
     */

    public static function distance(x1:Float, y1:Float, x2:Float, y2:Float):Float {
        var dx:Float = x1 - x2;
        var dy:Float = y1 - y2;

        return Math.sqrt(dx * dx + dy * dy);
    }

/**
     * Calculate angle of a point from a center point.
     */

    public static function polarAngle(point:Point, center:Point = null):Float {
        if (center != null)
            center = new Point(0, 0);

        var degrees:Float = Geometry.rad2deg(Math.atan2(point.y - center.y, point.x - center.x));

        if (degrees < 0)
            degrees += 360;

        return degrees;
    }

/**
     * Returns the x, y coordinate point on a circle for a given angle in degrees.
     */

    public static function pointOnCircle(degrees:Float, radius:Float):Point {
        var p:Point = new Point();

        p.x = radius + (radius * Math.cos(Geometry.deg2rad(degrees)));
        p.y = radius + (radius * Math.sin(Geometry.deg2rad(degrees)));

        return p;
    }

/**
     * Cartesian point from circle center, angle, and radius.
     */

    public static function pointOnCircleFromPoint(center:Point, angle:Float, radius:Float):Point {
        var p:Point = new Point();

        p.x = center.x + Math.cos(angle * Math.PI / 180) * radius;
        p.y = center.y + Math.sin(angle * Math.PI / 180) * radius;

        return p;
    }

/**
     * Returns the points on a bezier curve for a given time (0 - 1).
     */

    public static function pointOnCurve(p1x:Float, p1y:Float, cx:Float, cy:Float, p2x:Float, p2y:Float, t:Float):Point {
        return (new Point(p1x + t * (2 * (1 - t) * (cx - p1x) + t * (p2x - p1x)),
        p1y + t * (2 * (1 - t) * (cy - p1y) + t * (p2y - p1y))));
    }

/**
     * Convert degrees to radians.
     */

    public static function rad2deg(angle:Float):Float {
        angle = !Math.isNaN(angle) ? (angle) : (0);

        return angle * 180 / Math.PI;
    }

    /**
     * Return a random degree.
     */

    public static function randomAngle():Float {
        return (Math.random() * 360);
    }

    public static function randomAngleBetween(min:Float, max:Float):Float {
        return (min + (Math.random() * Math.abs(max - min)));
    }

    /**
     * Whether a point is within a rectangular bounds.
     *
     * @param x         Point x-coordinate to be tested.
     * @param y         Point y-coordinate to be tested.
     * @param bounds    Rectangle boundary to be tested against.
     * @return          True if point is within bounds.
     */

    public static function withinBounds(x:Float, y:Float, bounds:Rectangle):Bool {
        return ((x > bounds.x) &&
        (x < bounds.x + bounds.width) &&
        (y > bounds.y) &&
        (y < bounds.y + bounds.height));
    }

}
