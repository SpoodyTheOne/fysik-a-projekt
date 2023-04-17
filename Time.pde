// Global time manager
public static class Time {

  /* Members. */
  private static float s_LastFrameTime = 0;
  private static float s_DeltaTime = 0;
  private static float timeSpeedMult = 1;

  /* Getters/Setters. */
  public static float dt() { return s_DeltaTime * timeSpeedMult; }
  public static float timeScale() { return timeSpeedMult; }
  
  public static void Tick(float millis)
  {
    s_DeltaTime = (millis - s_LastFrameTime) / 1E9;
    s_LastFrameTime = millis;
  }
  
  public static void speedUp()
  {
    timeSpeedMult *= 2;
  }
  
  public static void speedDown()
  {
    timeSpeedMult /= 2;
  }
}
