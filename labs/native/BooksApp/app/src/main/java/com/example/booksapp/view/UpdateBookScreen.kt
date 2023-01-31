package com.example.booksapp.view

import android.widget.Toast
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.TextField
import androidx.compose.material3.Checkbox
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardCapitalization
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.example.booksapp.domain.Book

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun UpdateBookScreen(
    viewModel: BooksViewModel = hiltViewModel(),
    id: Int,
    navigateBack: () -> Unit,
) {
    LaunchedEffect(Unit) {
        viewModel.getBook(id)
    }

    Scaffold(
        topBar = { TopBar("Update book", navigateBack) },
        content = {
            UpdateBookContent(
                padding = it,
                book = viewModel.book,
                updateTitle = { title ->
                    viewModel.updateTitle(title)
                },
                updateAuthor = { author ->
                    viewModel.updateAuthor(author)
                },
                updateYear = { year ->
                    viewModel.updateYear(year)
                },
                updateLent = { lent ->
                    viewModel.updateLent(lent)
                },
                updateBook = { book ->
                    viewModel.updateBook(book)
                },
                navigateBack = navigateBack
            )
        }
    )
}


@Composable
fun UpdateBookContent(
    padding: PaddingValues,
    book: Book,
    updateTitle: (String) -> Unit,
    updateAuthor: (String) -> Unit,
    updateYear: (Int) -> Unit,
    updateLent: (Boolean) -> Unit,
    updateBook: (Book) -> Unit,
    navigateBack: () -> Unit,
) {
    val context = LocalContext.current
    val showMessage =
        { text: CharSequence -> Toast.makeText(context, text, Toast.LENGTH_SHORT).show() }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(padding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        TextField(
            value = book.title,
            onValueChange = updateTitle,
            placeholder = { Text("Title") },
            textStyle = TextStyle(color = Color.Magenta)
        )

        Spacer(modifier = Modifier.height(8.dp))

        TextField(
            value = book.author,
            onValueChange = updateAuthor,
            placeholder = { Text("Author") },
            textStyle = TextStyle(color = Color.Magenta)
        )

        Spacer(modifier = Modifier.height(8.dp))

        TextField(
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Number,
                capitalization = KeyboardCapitalization.None,
                autoCorrect = true,
                imeAction = ImeAction.Next,
            ),
            value = book.year.toString(),
            onValueChange = { updateYear(try {
                it.toInt()
            } catch (e: NumberFormatException) {
                0
            }) },
            placeholder = { Text("Year") },
            textStyle = TextStyle(color = Color.Magenta)
        )

        Spacer(modifier = Modifier.height(8.dp))

        Row (
            horizontalArrangement = Arrangement.Start,
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Checkbox( // https://www.geeksforgeeks.org/checkbox-in-android-using-jetpack-compose/
                checked = book.lent,
                onCheckedChange = { updateLent(it) },
                modifier = Modifier.padding(16.dp)
            )
            Text(text = "Lent", modifier = Modifier.padding(horizontal = 0.dp, vertical = 16.dp))
        }

        Button(onClick = {
            if (book.title.isBlank() || book.author.isBlank()) {
                showMessage("Please fill all fields")
            } else if (book.year < 0) {
                showMessage("Year must be a positive integer")
            } else {
                updateBook(book)
                showMessage("Book updated")
                navigateBack()
            }
        }) {
            Text(text = "Update")
        }
    }
}