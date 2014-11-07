/**
 * Created by space on 10/30/14.
 */

import scala.collection.JavaConverters._

object PrintEnvironment extends App {
  println("The environment is:")
  System.getenv.asScala.toSeq.sorted.map { case (k, v) =>
      println("\t"+k + " = " + v)
  }
}
