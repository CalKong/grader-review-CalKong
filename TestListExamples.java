import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}
public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test
  public void testFilter(){
    List<String> argList = Arrays.asList("moon", "moon1", "MOON", "moOn");
    List<String> expected = Arrays.asList("moon", "MOON", "moOn");
    StringChecker sc = new IsMoon();
    assertEquals(expected, ListExamples.filter(argList,sc));

  }
  @Test(timeout = 500)
  public void testMergeLeftEnd(){
    List<String> left = Arrays.asList("a", "d");
    List<String> right = Arrays.asList("a", "b", "c");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test(timeout = 500)
  public void testAlternate(){
    List<String> left = Arrays.asList("a", "c", "e");
    List<String> right = Arrays.asList("b", "d", "f");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "c", "d", "e", "f");
    assertEquals(expected, merged);
  }

  @Test(timeout= 500)
  public void diffLength(){
    List<String> left = Arrays.asList("a", "b", "c", "d", "e", "z");
    List<String> right = Arrays.asList("d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "b", "c", "d", "d", "e", "z");
    assertEquals(expected, merged);
  }


}
