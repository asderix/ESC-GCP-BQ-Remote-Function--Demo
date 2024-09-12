package example

import java.util.Optional
import com.google.cloud.functions.{HttpFunction, HttpRequest, HttpResponse}
import com.google.gson.Gson
import esc.similarity._
import esc.utils.Persistence._

case class BqRequest(
    requestId: String,
    caller: String,
    sessionUser: String,
    userDefinedContext: Map[String, Any],
    calls: Array[Array[String]]
)

class PersonNameSimilarity extends HttpFunction:
  override def service(request: HttpRequest, response: HttpResponse): Unit =
    val gson = new Gson()
    val reader = request.getReader
    val bqRequest = gson.fromJson(reader, classOf[BqRequest])
    val nameSimilarity = NameSimilarity()
    val result = bqRequest.calls.map(names => {
      val nameA = Optional.ofNullable(names(0)).orElse("")
      val nameB = Optional.ofNullable(names(1)).orElse("")
      nameSimilarity.getPersonNameSimilarity(nameA, nameB).similarity
    })
    val resultStr = result.mkString(", ")
    response.setContentType("application/json")
    response.getWriter.write(
      s"{ \"replies\": [$resultStr] }"
    )
